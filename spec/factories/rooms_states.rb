FactoryBot.define do
  factory :rooms_state do
    sequence(:name){ Faker::Lorem.word }
    association :enterprise
  end
end
