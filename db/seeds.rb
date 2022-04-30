# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "will create trainer..."
trainer = User.create!({
  email: "trainer@mewbnb.com",
  password: "password123"
})

puts "will create gym_leader..."
gym_leader = User.create!({
  email: "gymleader@mewbnb.com",
  password: "password123"
})


10.times do
  puts "will create pokemon..."
  pokemon = Pokemon.create!({
    name: Faker::Games::Pokemon.name,
    rate: rand(50..500),
    description: Faker::Games::Pokemon.move,
    location: Faker::Games::Pokemon.location,
    user: gym_leader
  })
  puts "will create booking..."
  Booking.create!({
    user: trainer,
    pokemon: pokemon,
    status: ["pending", "confirmed", "rejected"].sample,
    start_date: Faker::Date.between(from: 10.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: Date.today, to: 30.days.from_now)
  })
end
