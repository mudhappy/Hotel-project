FactoryBot.define do
  factory :user do
    sequence(:email){ Faker::Internet.email }
    password '12345678'
    association :enterprise

    trait :invalid do
      email nil
    end

    trait :without_enterprise do
      enterprise_id nil
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
