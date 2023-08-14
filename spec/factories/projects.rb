FactoryBot.define do
  factory :project do
    name { Faker::Lorem.sentence }
    date { Faker::Time.forward(days: 30) }
    association :creator, factory: :user 
    status { "pending" }

    trait :completed do
      status { "complete" }
    end
  end
end
