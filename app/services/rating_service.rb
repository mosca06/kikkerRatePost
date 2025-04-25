class RatingService
  def initialize(user_id, post_id, value)
    @user_id = user_id
    @post_id = post_id
    @value = value
  end

  def self.call(user_id, post_id, value)
    new(user_id, post_id, value).call
  end

  def call
    run
  end

  private

  def run
    return { errors: ['User already rated this Post.'] } if existing_rating

    rating = build_rating

    if rating.save
      { average_rating: average_rating(rating) }
    else
      { errors: rating.errors.full_messages }
    end
  rescue ActiveRecord::RecordNotUnique
    { errors: ['User already rated this Post.'] }
  end

  def existing_rating
    Rating.exists?(user_id: @user_id, post_id: @post_id)
  end

  def build_rating
    Rating.new(user_id: @user_id, post_id: @post_id, value: @value)
  end

  def average_rating(_rating)
    Rating.where(post_id: @post_id).average(:value).to_f
  end
end
