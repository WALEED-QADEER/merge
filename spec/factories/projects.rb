FactoryBot.define do
    factory :project do
      name { Faker::Lorem.sentence }
      date { Faker::Time.forward(days: 30) }
      association :creator, factory: :manager 
      status { 0 }
      
 
      trait :completed do
        status { 2 }
      end
    end
  end
  