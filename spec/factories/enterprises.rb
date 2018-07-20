FactoryBot.define do
  factory :enterprise do
    sequence(:name){ Faker::Company.name }
    sequence(:ruc){ Faker::Number.number(11) }  
  end
end
