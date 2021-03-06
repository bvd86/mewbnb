require 'json'
require 'rest-client'
require 'open-uri'

class PokemonsController < ApplicationController
  before_action :find_pokemon, only: [:show, :edit, :update, :destroy]
  before_action :find_user

  def edit; end

  def index
    # Search
    if params[:query].present?
      @pokemons = Pokemon.search_pokemon(params[:query])
    else
       @pokemons = Pokemon.all.order(rate: :desc)
    end

    # Map attributes
    @markers = @pokemons.geocoded.map do |pokemon|
      {
        lat: pokemon.latitude,
        lng: pokemon.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { pokemon: pokemon }),
        image_url: helpers.asset_url("location.png")
      }
    end
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = @user

    # Fetching the pokemon type
    if @pokemon.name.present?
      response = RestClient.get "https://pokeapi.co/api/v2/pokemon/#{@pokemon.name.downcase}/"
      poke_info = JSON.parse(response, symbolize_names: true)
      poke_type = poke_info[:types][0][:type][:name]
      @pokemon.pokemon_type = poke_type.capitalize

      attach_pic if @pokemon.picture.attached? == false
    end

    if @pokemon.save
      redirect_to pokemon_path(@pokemon)
    else
      render :new
    end
   end

  def show;
    @gym_leader = @pokemon.user
    @pokemons = Pokemon.all
    @booking = Booking.new

    # Map attributes
    @markers = [{
      lat: @pokemon.latitude,
      lng: @pokemon.longitude,
      info_window: render_to_string(partial: "shared/info_window", locals: { pokemon: @pokemon }),
      image_url: helpers.asset_url("location.png")
    }]
  end

  def update
    @pokemon.update(pokemon_params)

    redirect_to pokemon_path(@pokemon)
  end

  def destroy
    @pokemon.destroy!

    redirect_to pokemons_path
  end

  def my_listings
    @pokemons = Pokemon.where(user: current_user)
  end



  private

  def find_user
    @user = current_user
  end

  def find_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :pokemon_type, :level,
                                   :location, :rate, :description, :picture)
  end

  def attach_pic
    response = RestClient.get "https://pokeapi.co/api/v2/pokemon/#{@pokemon.name.downcase}/"
    poke_info = JSON.parse(response, symbolize_names: true)
    poke_id = poke_info[:id]
    @pokemon.pokedex_entry = poke_id

    pic_url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/#{@pokemon.pokedex_entry}.png"
    filename = File.basename(URI.parse(pic_url).path)
    file = URI.open(pic_url)
    @pokemon.picture.attach(io: file, filename: filename)
  end
end
