FactoryBot.define do
  factory :booking do
    date { Faker::Date.in_date_period }

    association :campsite
  end
end
