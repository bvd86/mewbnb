class RemoveFieldNameFromTableName < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :is_gym_leader, :boolean
  end
end
