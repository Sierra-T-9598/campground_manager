FactoryBot.define do
  factory :campground do
    name { Faker::Mountain.range }
  end

  # Could be used to clean up tests at a later point
  
  # def campground_with_campsites(site_count: 3)
  #   FactoryBot.create(:campground) do |campground|
  #     FactoryBot.create_list(:campsite, site_count, campground_id: campground.id)
  #   end
  # end
end
