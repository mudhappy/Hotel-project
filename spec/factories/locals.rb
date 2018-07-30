FactoryBot.define do
  factory :local do
    sequence(:address){ Faker::Address.street_address }
    sequence(:stars){ Faker::Number.between(1,5) }
    association :enterprise
  end
end
