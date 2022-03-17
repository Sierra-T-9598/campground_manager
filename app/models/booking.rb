class Booking < ApplicationRecord
  belongs_to :campsite

  validates_presence_of :date
end
