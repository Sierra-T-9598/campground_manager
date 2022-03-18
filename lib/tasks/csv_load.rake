require 'csv'

namespace :csv_load do
  task all: [:campgrounds, :bookings]

  task campgrounds: :environment do
    CSV.foreach('./db/data/sample_campground_data.csv', headers: true) do |row|
      campground = Campground.find_or_create_by!(name: row[0])
      campground.campsites.create!(name: row[1], price: row[2])
    end
  end

  # Added to check endpoints in Postman
  task bookings: :environment do
    CSV.foreach('./db/data/booking_data.csv', headers: true) do |row|
      campsite = Campsite.find_by(id: row[1])
      campsite.bookings.create!(date: row[0])
    end
  end
end
