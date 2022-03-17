class AddCampgroundsToCampsites < ActiveRecord::Migration[5.2]
  def change
    add_reference :campsites, :campground, foreign_key: true
  end
end
