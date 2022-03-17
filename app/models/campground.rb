class Campground < ApplicationRecord
  has_many :campsites

  validates_presence_of :name
end
