class AddCoordinatesToPokemons < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :latitude, :float
    add_column :pokemons, :longitude, :float
  end
end
