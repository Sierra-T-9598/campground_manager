class CreateCampsites < ActiveRecord::Migration[5.2]
  def change
    create_table :campsites do |t|
      t.string :name
      t.float :price
      t.string :booked_dates

      t.timestamps
    end
  end
end
