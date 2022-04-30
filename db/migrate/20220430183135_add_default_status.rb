class AddDefaultStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :bookings, :status, :string, :default => "available"
  end
end
