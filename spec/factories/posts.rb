FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    ip { Faker::Internet.ip_v4_address }
    user
  end
end
