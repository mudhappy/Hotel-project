FactoryBot.define do
  factory :user do
    sequence(:email){ Faker::Internet.email }
    password '12345678'
    enterprise nil

    trait :invalid do
      email nil
    end

    trait :with_enterprise do
      association :enterprise
    end

    trait :root do
      role 'root'
    end

    trait :admin do
      role 'admin'
    end

    trait :employee do
      role 'employee'
    end
  end
end
