class PokemonsController < ApplicationController
  before_action :find_pokemon, only: [:show, :edit, :update]
  before_action :find_user

  # def create
  #   @pokemon = Pokemon.new(pokemon_params)
  #   @pokemon.user_id = @user.id
  #   if @pokemon.save!
  #     redirect_to pokemon_path(@pokemon)
  #   else
  #     render :new
  #   end
  # end

  # def edit; end

  def index
    @pokemons = Pokemon.all.order(rate: :desc)
  end

  # def new
  #   @pokemon = Pokemon.new
  # end

  def show
  end

  # def update
  #   @pokemon.update(pokemon_params)

  #   redirect_to pokemon_path(@pokemon)
  # end

  private

  def find_user
    @user = current_user
  end

  def find_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :type, :level,
                                   :location, :rate, :description, :picture)
  end
end
