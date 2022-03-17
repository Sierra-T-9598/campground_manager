require 'csv'

namespace :csv_load do
  task campgrounds: :environment do
    CSV.foreach('./db/data/sample_campground_data.csv', headers: true) do |row|
      campground = Campground.create!(row[0].to_hash)
      campground.campsites.create!(row[1..2].to_hash)
    end
  end
end
