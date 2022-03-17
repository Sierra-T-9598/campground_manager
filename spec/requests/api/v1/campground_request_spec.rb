require 'rails_helper'

RSpec.describe 'Campground Endpoints' do

  let!(:campground_1) { create(:campground, name: "Moraine Park") }
  let!(:campground_2) { create(:campground, name: "Arches") }
  let!(:campground_3) { create(:campground, name: "Crater Lake") }

  let!(:site_1) { create(:campsite, campground_id: campground_1.id, name: "1" )}
  let!(:site_2) { create(:campsite, campground_id: campground_1.id, name: "2" ) }
  let!(:site_3) { create(:campsite, campground_id: campground_2.id) }
  let!(:site_4) { create(:campsite, campground_id: campground_2.id) }
  let!(:site_5) { create(:campsite, campground_id: campground_3.id) }
  let!(:site_6) { create(:campsite, campground_id: campground_3.id) }

  let!(:booking_1) { create(:booking, campsite_id: site_1.id) }
  let!(:booking_2) { create(:booking, campsite_id: site_1.id) }
  let!(:booking_3) { create(:booking, campsite_id: site_2.id) }
  let!(:booking_4) { create(:booking, campsite_id: site_2.id) }
  let!(:booking_5) { create(:booking, campsite_id: site_3.id) }
  let!(:booking_6) { create(:booking, campsite_id: site_3.id) }

  describe 'get /campgrounds' do
    describe 'campgrounds exist in database' do
      it 'returns all campgrounds in JSON' do
        get '/api/v1/campgrounds'
        campgrounds = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(200)

        expect(campgrounds).to have_key(:data)
        expect(campgrounds[:data].count).to eq(3)

        campgrounds[:data].each do |campground|
          expect(campground[:id]).to be_a String
          expect(campground[:attributes][:name]).to be_a String
          expect(campground[:attributes][:booked_dates]).to be_an Array
          expect(campground[:attributes][:price_range]).to be_a String
        end
      end
    end
  end

  #   describe 'there are no campgrounds in database' do
  #     it 'returns an empty JSON string' do
  #       get '/api/v1/campgrounds'
  #       campgrounds = JSON.parse(response.body, symbolize_names: true)
  #       expect(response.status).to eq(200)
  #
  #       expect(campgrounds).to have_key(:data)
  #       expect(campgrounds[:data]).to eq([])
  #     end
  #   end
  # end

  describe 'get /campground/:id' do
    describe 'the campground exists' do
      it 'returns the campground in JSON' do
        get "/api/v1/campgrounds/#{campground_1.id}"
        campground = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(campground).to have_key(:data)

        expect(campground[:data][:id]).to be_a String
        expect(campground[:data][:attributes][:name]).to be_a String
        expect(campground[:data][:attributes][:booked_dates]).to be_an Array
        expect(campground[:data][:attributes][:price_range]).to be_a String
      end
    end

    describe 'the campground record does not exist' do
      it 'reuturns a 404 status and error message' do
        get "/api/v1/campgrounds/48923"

        no_campground = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(404)
        expect(no_campground).to have_key(:error)
        expect(no_campground[:error][:exception]).to eq("Couldn't find Campground with 'id'=48923")
      end
    end
  end

  describe 'post /campgrounds' do
    describe 'request to create a new campground with valid parameters' do
      it 'generates response of the new campground in JSON' do
        # campsite_params = { name: "Backcountry 1", booked_dates: "6/4/22", price: 15.0 }
        campground_params = { name: 'Heart Lake' }
        headers = { 'CONTENT_TYPE' => 'application/json'}

        post '/api/v1/campgrounds', headers: headers, params: JSON.generate(campground: campground_params)
        created_camp = Campground.last
        expect(response.status).to eq(201)
        expect(created_camp.name).to eq('Heart Lake')
      end
    end

    describe 'request to create a new campground with invalid parameters' do
      it 'generates 400 status for RecordInvalid' do
        campground_params = { name: nil }
        headers = { 'CONTENT_TYPE' => 'application/json'}

        post '/api/v1/campgrounds', headers: headers, params: JSON.generate(campground: campground_params)

        expect(response.status).to eq(400)
      end
    end
  end

  describe 'patch /campgrounds' do
    describe 'request to update a campground with existing id' do
      it 'generates an updated campground response' do
        campground_id = campground_2.id
        previous_name = campground_2.name
        expect(previous_name).to eq('Arches')

        campground_params = { name: 'Aspen Glen' }
        headers = { 'CONTENT_TYPE' => 'application/json'}

        patch "/api/v1/campgrounds/#{campground_id}", headers: headers, params: JSON.generate({campground: campground_params})
        updated_campground = Campground.find_by(id: campground_id)

        expect(response.status).to eq(200)
        expect(updated_campground.name).to eq('Aspen Glen')
        expect(updated_campground.booked_dates).to eq([booking_5.date, booking_6.date])
        expect(updated_campground.price_range).to be_a String
      end
    end

    describe 'request to update a campground with id that does not exist' do
      it 'returns a 404 status for RecordNotFound' do
        campground_id = 789
        campground_params = { name: 'No name' }
        headers = { 'CONTENT_TYPE' => 'application/json'}

        patch "/api/v1/campgrounds/#{campground_id}", headers: headers, params: JSON.generate({campground: campground_params})

        expect(response.status).to eq(404)
      end

      describe 'request to updated a campground with invalid parameters' do
        it 'returns a 400 status for RecordInvalid' do
          campground_id = campground_2.id
          previous_name = campground_2.name
          expect(previous_name).to eq('Arches')

          campground_params = { name: nil }
          headers = { 'CONTENT_TYPE' => 'application/json'}

          patch "/api/v1/campgrounds/#{campground_id}", headers: headers, params: JSON.generate({campground: campground_params})
          not_updated_campground = Campground.find_by(id: campground_id)

          expect(not_updated_campground.name).to eq('Arches')
          expect(response.status).to eq(400)
        end
      end
    end
  end

  describe 'delete /campgrounds/:id' do
    describe 'request to delete a campground by existing id' do
      it 'returns a 204 status after finding and deleting campground' do
        campground = create(:campground)

        expect{ delete "/api/v1/campgrounds/#{campground.id}" }.to change(Campground, :count).by(-1)

        expect(response.status).to eq(204)
        expect(response.body).to be_empty
      end

      describe 'request to delete a campground with invalid id' do
        it 'returns a 404 status for RecordNotFound' do
          id = 999
          delete "/api/v1/campgrounds/#{id}"
          expect(response.status).to eq(404)
        end
      end
    end
  end
end
