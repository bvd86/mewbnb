class ChangeTypeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :pokemons, :type, :pokemon_type
  end
end
