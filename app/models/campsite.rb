class Campsite < ApplicationRecord
  belongs_to :campground

  validates_presence_of :name
  validates_presence_of :booked_dates, on: :create_booking
  validates_presence_of :price
  
  def create_booking
  end
end
