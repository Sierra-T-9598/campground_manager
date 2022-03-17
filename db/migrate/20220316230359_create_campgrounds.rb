class CreateCampgrounds < ActiveRecord::Migration[5.2]
  def change
    create_table :campgrounds do |t|
      t.string :name

      t.timestamps
    end
  end
end
