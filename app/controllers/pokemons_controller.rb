# require 'json'
# require 'rest-client'
# require 'open-uri'

class PokemonsController < ApplicationController
  before_action :find_pokemon, only: [:show, :edit, :update, :destroy]
  before_action :find_user

  def edit; end

  def index
    @pokemons = Pokemon.all.order(rate: :desc)

    # Map attributes
    @markers = @pokemons.geocoded.map do |pokemon|
      {
        lat: pokemon.latitude,
        lng: pokemon.longitude,
        info_window: render_to_string(partial: "info_window", locals: { pokemon: pokemon })
      }
    end
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = @user

    if @pokemon.save!
      redirect_to pokemon_path(@pokemon)
    else
      render :new
    end
   end

  def show;
    @gym_leader = @pokemon.user
    @pokemons = Pokemon.all
  end

  def update
    @pokemon.update(pokemon_params)

    redirect_to pokemon_path(@pokemon)
  end

  def destroy
    @pokemon.destroy!

    redirect_to pokemons_path
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
end
