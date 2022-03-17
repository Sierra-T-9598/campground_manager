FactoryBot.define do
  factory :campsite do
    name { Faker::Mountain.name }
    price { Faker::Number.between(from: 10, to: 45).to_s }
    booked_dates { nil }

    association :campground
  end
end
