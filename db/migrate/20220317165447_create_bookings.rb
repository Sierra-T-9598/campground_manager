class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :date

      t.timestamps
    end
  end
end
