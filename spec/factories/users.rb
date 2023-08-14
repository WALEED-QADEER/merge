FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" } 
    role { 0 }  
  end
  
  factory :manager, parent: :user do
    role { 1 }
  end
  
  factory :qa, parent: :user do
    role { 2 }
  end
end
