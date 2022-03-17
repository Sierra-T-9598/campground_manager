class CampgroundSerializer
  include JSONAPI::Serializer

  attributes :name, :booked_dates, :price_range

end
