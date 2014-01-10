namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Rails Tutorial", email: "example@railstutorial.org",
                 password: "foobar", password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "foobar"
      password_confirmation = "foobar"
      User.create!(name: name, email: email, password: password,
                   password_confirmation: password_confirmation)
    end

    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end
