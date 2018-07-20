FactoryBot.define do
  factory :user do
    sequence(:email){ Faker::Internet.email }
    password '12345678'
  end
end
