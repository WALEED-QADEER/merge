FactoryBot.define do
    factory :project do
      id { Faker::Number.unique.between(from: 1, to: 1000) }
      name { Faker::Lorem.sentence }
      date { Faker::Time.forward(days: 30) }
      association :creator, factory: :user 
      status { 0 }
      
 
      trait :completed do
        status { 2 }
      end
    end
  end
  