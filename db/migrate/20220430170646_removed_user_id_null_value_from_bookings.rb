class RemovedUserIdNullValueFromBookings < ActiveRecord::Migration[6.1]
  def change
    change_column :bookings, :user_id, :integer, null: true
  end
end
