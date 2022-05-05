# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'json'
require 'rest-client'
require 'open-uri'


if User.count == 0
  puts "creating trainer..."
  user = User.create!({
    email: "user@mewbnb.com",
    password: "password123"
  })
end

40.times do
  puts "creating pokemon..."
  id = rand(1..151)
  location_id = rand(1..93)

  # For name & type
  response = RestClient.get "https://pokeapi.co/api/v2/pokemon/#{id}/"
  poke_info = JSON.parse(response, symbolize_names: true)
  # For description
  response = RestClient.get "https://pokeapi.co/api/v2/pokemon-species/#{id}/"
  poke_desc = JSON.parse(response, symbolize_names: true)
  # For location
  response = RestClient.get "https://pokeapi.co/api/v2/region/1/"
  poke_location = JSON.parse(response, symbolize_names: true)

  pokemon = Pokemon.create!({
    name: poke_info[:forms][0][:name].titleize,
    pokedex_entry: id,
    rate: rand(50..500),
    description: poke_desc[:flavor_text_entries][0][:flavor_text],
    location: poke_location[:locations][location_id][:name].titleize.tr("-", ""),
    user: User.first,
    pokemon_type: poke_info[:types][0][:type][:name].capitalize,
    level: rand(1..100),
  })

  pic_url = poke_info[:sprites][:front_default]

  filename = File.basename(URI.parse(pic_url).path)
  file = URI.open(pic_url)

  pokemon.picture.attach(io: file, filename: filename)

  puts "creating booking..."
  Booking.create!({
    pokemon: pokemon,
    status: ["Available", "Booked", "Canceled"].sample,
    start_date: Faker::Date.between(from: 10.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: Date.today, to: 30.days.from_now)
  })
end
