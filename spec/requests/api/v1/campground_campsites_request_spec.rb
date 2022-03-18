require 'rails_helper'

RSpec.describe 'Campground Campsites Endpoint' do
  let!(:campground_1) { create(:campground, name: "Moraine Park") }
  let!(:campground_2) { create(:campground, name: "Arches") }
  let!(:campground_3) { create(:campground, name: "Crater Lake") }

  let!(:site_1) { create(:campsite, price: 10.0, campground_id: campground_1.id, name: "1" )}
  let!(:site_2) { create(:campsite, price: 10.0, campground_id: campground_1.id, name: "2" ) }
  let!(:site_3) { create(:campsite, price: 5.0, campground_id: campground_2.id) }
  let!(:site_4) { create(:campsite, price: 5.0, campground_id: campground_2.id) }
  let!(:site_5) { create(:campsite, price: 5.0, campground_id: campground_3.id) }
  let!(:site_6) { create(:campsite, price: 8.0, campground_id: campground_3.id) }

  let!(:booking_1) { create(:booking, date: '5/6/22', campsite_id: site_1.id) }
  let!(:booking_2) { create(:booking, date: '5/7/22', campsite_id: site_1.id) }
  let!(:booking_3) { create(:booking, date: '5/8/22', campsite_id: site_1.id) }
  let!(:booking_4) { create(:booking, date: '5/6/22', campsite_id: site_2.id) }
  let!(:booking_5) { create(:booking, date: '5/7/22', campsite_id: site_2.id) }
  let!(:booking_6) { create(:booking, date: '5/8/22', campsite_id: site_2.id) }

  describe 'get all campsites at a campground' do
    it 'returns the JSON of all campsites for a given campground' do
      id = campground_1.id
      get "/api/v1/campgrounds/#{id}/campsites"

      campsites = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)

      expect(campsites).to have_key(:data)
      expect(campsites[:data].count).to eq(2)

      campsites[:data].each do |campsite|
        expect(campsite[:id]).to be_a String
        expect(campsite[:attributes][:name]).to be_a String
        expect(campsite[:attributes][:booked_dates]).to be_an Array
        expect(campsite[:attributes][:price]).to be_a Float
      end
    end
  end
end
