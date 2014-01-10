namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Rails Tutorial", email: "example@railstutorial.org",
                 password: "foobar", password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "foobar"
      password_confirmation = "foobar"
      User.create!(name: name, email: email, password: password,
                   password_confirmation: password_confirmation)
    end
  end
end
