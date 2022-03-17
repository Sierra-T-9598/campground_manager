class Campground < ApplicationRecord
  has_many :campsites

  validates_presence_of :name
  # after_create :booked_dates
  # after_create :price_range

  def booked_dates
    # dates = []
    # campsites.map do |campsite|
    #   dates << campsite.booked_dates
    # end
    # return dates
    dates = []
    campsites.map do |campsite|
      dates << campsite.booked_dates
    end
    return dates.flatten
  end

  def price_range
    campsites.order(:price)
    highest = campsites.first.price
    lowest = campsites.last.price
    range = "$#{lowest} to $#{highest}"
    return range
  end
end
