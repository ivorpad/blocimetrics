require 'faker'

  user = User.new(
    name: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save

  10.times do
    registered_application = RegisteredApplication.create!(
      user: user,
      name: Faker::App.name,
      url: Faker::Internet.url
    )
  end

  registered_applications = RegisteredApplication.all

  5.times do
    event = Event.create!(
      name: Faker::Hacker.noun,
      registered_application: registered_applications.sample
    )
  end

puts "Seeds finished"
puts "#{RegisteredApplication.count} apps created"
puts "#{Event.count} events created"
