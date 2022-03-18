class Campsite < ApplicationRecord
  belongs_to :campground
  has_many :bookings

  validates_presence_of :name
  validates_presence_of :price

  def booked_dates
    bookings.map do |booking|
      booking.date
    end
  end

  def booked?(from, to)
    if bookings == []
      return false
    else
      bookings.map do |booking|
        if booking.date == from || booking.date == to
          return true
        else
          return false
        end
      end
    end
  end
end
