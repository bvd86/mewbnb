class AddGymLeader < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_gym_leader, :boolean
  end
end
