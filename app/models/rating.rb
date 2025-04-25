class Rating < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :value, inclusion: { in: 1..5, message: "must be between 1 and 5." }
  validates_uniqueness_of :user_id, scope: :post_id, message: "User already rated this Post."
end
