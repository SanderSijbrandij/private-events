# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:                  "Example User",
             email:                 "example@example.com",
             password:              "foobar",
             password_confirmation: "foobar")

Event.create!(name:        "Example Event",
              description: "This is the description of an example event made by the first user in the database.",
              location:    "In my house",
              happens_at:  Time.now,
              creator_id:  1)

49.times do |n|
  name     = Faker::Name.name
  email    = "example-#{n+1}@example.org"
  password = "password"
  User.create!(name:                  name,
               email:                 email,
               password:              password,
               password_confirmation: password)
end

49.times do |n|
  name        = "Event-#{n+1}"
  description = Faker::Lorem.paragraph
  location    = Faker::Address.street_address
  happens_at  = Faker::Time.between(DateTime.now, 10.days.from_now)
  creator_id  = Faker::Number.between(1,50)
  Event.create!(name:        name,
                description: description,
                location:    location,
                happens_at:  happens_at,
                creator_id:  creator_id)
end

Event.all.each do |event|
  id      = event.id
  creator = event.creator_id
  EventUser.create!(event_id: id, user_id: creator)
end
