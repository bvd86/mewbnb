class AddPokedexEntryToPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :pokedex_entry, :string
  end
end
