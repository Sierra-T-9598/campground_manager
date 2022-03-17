class Campsite < ApplicationRecord
  belongs_to :campground
  has_many :bookings

  validates_presence_of :name
  # validates_presence_of :booked_dates, on: :create_dates
  validates_presence_of :price

  # after_create :create_dates

  def booked_dates
    bookings.map do |booking|
      booking.date
    end
  end
end
