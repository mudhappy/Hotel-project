FactoryBot.define do
  factory :user do
    sequence(:email){ Faker::Internet.email }
    password '12345678'

    trait :invalid do
      email nil
    end

    trait :with_token do
      sequence(:authentication_token){ Faker::Lorem.characters(30) }
    end
  end
end
