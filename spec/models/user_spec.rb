require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:ratings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:login) }
  end

  describe 'validations for uniqueness' do
    it 'is expected to validate that login is unique' do
      user1 = create(:user, login: 'user123')
      user2 = build(:user, login: 'user123')

      expect(user1).to be_valid
      expect(user2).not_to be_valid
      expect(user2.errors[:login]).to include('Usuário já existe')
    end
  end
end
