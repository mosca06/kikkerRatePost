FactoryBot.define do
  factory :rating do
    value { Faker::Number.between(from: 1, to: 5) }
    post
    user
  end
end
