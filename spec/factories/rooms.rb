FactoryBot.define do
  factory :room do
    sequence(:price) { Faker::Number.decimal(2) }
    sequence(:dni) { Faker::Number.number(10) }
    sequence(:roomer_quantities) { Faker::Number.between(1,3) }
    sequence(:left_at) { nil }
    association :rooms_type
    association :rooms_state
    association :enterprise
  end
end
