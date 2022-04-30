class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :type
      t.integer :level
      t.string :location
      t.integer :rate
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
