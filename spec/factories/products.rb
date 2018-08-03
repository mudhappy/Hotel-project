FactoryBot.define do
  factory :product do
    sequence(:name){ Faker::Food.fruits }
    sequence(:purchase_price){ Faker::Number.decimal(2) }
    sequence(:sale_price){ Faker::Number.decimal(2) }
    sequence(:quantity){ Faker::Number.between(7, 10) }

    association :enterprise
  end
end
