FactoryGirl.define do
  factory :micropost do
    content Faker::Lorem.sentence(5)
  end
end
