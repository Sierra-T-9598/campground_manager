require 'csv'

namespace :csv_load do
  task campgrounds: :environment do
    CSV.foreach('./db/data/sample_campground_data.csv', headers: true) do |row|
      campground = Campground.find_or_create_by!(name: row[0])
      campground.campsites.create!(name: row[1], price: row[2])
    end
  end
end
