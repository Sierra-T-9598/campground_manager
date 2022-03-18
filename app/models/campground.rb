class Campground < ApplicationRecord
  has_many :campsites
  has_many :bookings, through: :campsites
  validates_presence_of :name

  def booked_dates
    dates = []
    campsites.map do |campsite|
      dates.push("#{campsite.booked_dates}, #{campsite.name}")
    end
    return dates.flatten.uniq
  end

  def lowest_price
    campsites
    .select("campsites.*, campsites.price")
    .group('campsites.id')
    .order('campsites.price asc')
    .first
    .price
  end

  def highest_price
    campsites
    .select("campsites.*, campsites.price")
    .group('campsites.id')
    .order('campsites.price asc')
    .last
    .price
  end

  def price_range
    range = "$#{lowest_price} to $#{highest_price}"
  end

  def no_vacancy?(from,to)
    counter = 0
    campsites.each do |site|
      if site.booked?(from,to) == true
        counter += 1
      end
    end
    if campsites.count == counter
      true
    else
      false
    end
  end

  def self.availability(from, to)
    available = []
    self.all.each do |campground|
      unless campground.no_vacancy?(from, to) == true
        available << campground
      end
    end
    available
  end

  def self.price_high_to_low
    joins(:campsites)
    .select("campgrounds.*, avg(campsites.price) as average")
    .group(:id)
    .order(average: :desc)
  end

  def self.price_low_to_high
    joins(:campsites)
    .select("campgrounds.*, avg(campsites.price) as average")
    .group(:id)
    .order(average: :asc)
  end
end
