class AddCampsitesToBookings < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookings, :campsite, foreign_key: true
  end
end
