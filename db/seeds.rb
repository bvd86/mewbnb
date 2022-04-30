# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

if User.count == 0
  puts "will create trainer..."
  user = User.create!({
    email: "user@mewbnb.com",
    password: "password123"
  })
end

10.times do
  puts "will create pokemon..."
  pokemon = Pokemon.create!({
    name: Faker::Games::Pokemon.name,
    rate: rand(50..500),
    description: Faker::Games::Pokemon.move,
    location: Faker::Games::Pokemon.location,
    user: User.first,
    pokemon_type: ["normal", "fire", "water", "grass", "electric", "ice", "fighting", "poison", "psychic", "ground", "flying", "bug", "rock", "ghost", "dark", "dragon", "steel", "fairy"].sample,
    level: rand(1..100)
  })
  puts "will create booking..."
  Booking.create!({
    pokemon: pokemon,
    status: ["available", "requested", "booked"].sample,
    start_date: Faker::Date.between(from: 10.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: Date.today, to: 30.days.from_now)
  })
end
