class CampsiteSerializer
  include JSONAPI::Serializer

  attributes :name, :booked_dates, :price

end
