FactoryBot.define do
  factory :rooms_type do
    sequence(:name){ Faker::Lorem.word }
    sequence(:bed_cuantities){ Faker::Number.between(1,3) }
    sequence(:recommended_price){ Faker::Number.decimal }
    association :enterprise
  end
end
