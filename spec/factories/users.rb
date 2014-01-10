FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'foobar'
    password_confirmation 'foobar'

    factory :admin do
      admin true
    end
  end
end
