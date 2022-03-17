class Campsite < ApplicationRecord
  belongs_to :campground

  validates_presence_of :name
  validates_presence_of :booked_dates
  validates_presence_of :price
end
