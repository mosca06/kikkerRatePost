require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it 'valida que o valor tem que ser entre 1 e 5' do
      invalid_value = rand(1..2) == 1 ? rand(-100..0) : rand(6..100)
      rating = build(:rating, user: user, post: post, value: invalid_value)

      expect(rating).not_to be_valid
      expect(rating.errors.full_messages).to include('Value must be between 1 and 5.')

      random_value = rand(1..5)
      rating = build(:rating, user: user, post: post, value: random_value)

      expect(rating).to be_valid
    end

    it 'valida que nao tem duplicaçao de avaliaçao' do
      create(:rating, user: user, post: post, value: 4)
      rating2 = build(:rating, user: user, post: post, value: 3)

      expect(rating2).not_to be_valid
      expect(rating2.errors[:user_id]).to include('User already rated this Post.')

      user2 = create(:user)
      rating3 = build(:rating, user: user2, post: post, value: 5)

      expect(rating3).to be_valid
    end
  end
end
