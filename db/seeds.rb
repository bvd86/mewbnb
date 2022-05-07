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

locations = [
  "7503 Rue St Denis, Montreal QC",
  "576 Boul Saint-Luc, Saint-Jean-Sur-Richelieu, QC",
  "590 Rue de la Congrégation, Montreal QC",
  "596 Blou Bourg-Neuf, Repentigny, QC",
  "472 Rue Caroline, Longueuil, QC",
  "2581 Rue la Jonquière, Trois-Rivières, QC",
  "140 Rue des Mille-Îles, Saint-Eustache, QC",
  "286 Dufferin St, Hampstead, QC",
  "8511 Rue Grenache, Anjou, QC",
  "465 Rue Théberge, Terrebonne, QC",
  "10408 Rue Meilleur, Montréal, QC",
  "141 Rue Ranger, L'Île-Perrot, QC",
  '251 Av Percival Montreal Ouest QC',
  '11727 Rue Notre Dame E, Montreal QC',
  '3708 Rue St Hubert, Montreal QC',
  '800 Rue Gagne Lasalle QC',
  '16 Saint-Viateur O., Montreal QC',
  '4107 Boulevard Saint-Laurent, Montreal QC',
  '5930 Rue Hurteau, Montreal QC',
  '6730 44 Av, Montreal QC',
  '1940 Jolicoeur Street, Montreal QC',
  '5240 Randall Av, Montreal QC',
  '3555 Edouard-Montpetit, Montreal QC',
  '12225 Av de Saint-Castin, Montreal QC',
  '391 Rue de la Congrégation, Montreal QC'
 ]

if Pokemon.count == 0
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
      location: locations.sample,
      user: User.first,
      pokemon_type: poke_info[:types][0][:type][:name].capitalize,
      level: rand(1..100),
    })

    pic_url = poke_info[:sprites][:other][:"official-artwork"][:front_default]

    filename = File.basename(URI.parse(pic_url).path)
    file = URI.open(pic_url)

    pokemon.picture.attach(io: file, filename: filename)

    puts "creating booking..."
    Booking.create!({
      pokemon: pokemon,
      status: ["Available", "Confirmed", "Cancelled", "Pending"].sample,
      start_date: Faker::Date.between(from: 10.days.ago, to: Date.today),
      end_date: Faker::Date.between(from: Date.today, to: 30.days.from_now)
    })
  end
end
