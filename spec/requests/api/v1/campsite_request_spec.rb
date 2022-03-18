require 'rails_helper'

RSpec.describe 'Campsite Endpoints' do

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

  describe 'get /campsites' do
    describe 'campsites exist in database' do
      it 'returns all campsites in JSON' do
        get '/api/v1/campsites'
        campsites = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(200)

        expect(campsites).to have_key(:data)
        expect(campsites[:data].count).to eq(6)

        campsites[:data].each do |campsite|
          expect(campsite[:id]).to be_a String
          expect(campsite[:attributes][:name]).to be_a String
          expect(campsite[:attributes][:booked_dates]).to be_an Array
          expect(campsite[:attributes][:price]).to be_a Float
        end
      end
    end
  end

  describe 'get /campsite/:id' do
    describe 'the campsite exists' do
      it 'returns the campsite in JSON' do
        get "/api/v1/campsites/#{site_1.id}"
        campsite = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(campsite).to have_key(:data)

        expect(campsite[:data][:id]).to be_a String
        expect(campsite[:data][:attributes][:name]).to be_a String
        expect(campsite[:data][:attributes][:booked_dates]).to be_an Array
        expect(campsite[:data][:attributes][:price]).to be_a Float
      end
    end

    describe 'the campsite record does not exist' do
      it 'reuturns a 404 status and error message' do
        get "/api/v1/campsites/48923"

        no_site = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(404)
        expect(no_site).to have_key(:error)
        expect(no_site[:error][:exception]).to eq("Couldn't find Campsite with 'id'=48923")
      end
    end
  end

  describe 'post /campsites' do
    describe 'request to create a new campsite with valid parameters' do
      it 'generates response of the new campsite in JSON' do
        # campsite_params = { name: "Backcountry 1", booked_dates: "6/4/22", price: 15.0 }
        campground = create(:campground)
        campsite_params = { name: 'Heart Lake Site 1', booked_dates: ["6/4/22", "6/5/22"], price: 10.0, campground_id: campground.id }
        headers = { 'CONTENT_TYPE' => 'application/json'}

        post '/api/v1/campsites', headers: headers, params: JSON.generate(campsite: campsite_params)
        created_site = Campsite.last

        expect(response.status).to eq(201)
        expect(created_site.name).to eq('Heart Lake Site 1')
      end
    end

    describe 'request to create a new campsite with invalid parameters' do
      it 'generates 400 status for RecordInvalid' do
        campsite_params = { name: nil }
        headers = { 'CONTENT_TYPE' => 'application/json'}

        post '/api/v1/campsites', headers: headers, params: JSON.generate(campsite: campsite_params)

        expect(response.status).to eq(400)
      end
    end
  end

  describe 'patch /campsites' do
    describe 'request to update a campsite with existing id' do
      it 'generates an updated campsite response' do
        campsite_id = site_2.id
        previous_name = site_2.name
        expect(previous_name).to eq('2')

        campsite_params = { name: 'Aspen Glen Site 2' }
        headers = { 'CONTENT_TYPE' => 'application/json'}

        patch "/api/v1/campsites/#{campsite_id}", headers: headers, params: JSON.generate({campsite: campsite_params})
        updated_campsite = Campsite.find_by(id: campsite_id)

        expect(response.status).to eq(200)
        expect(updated_campsite.name).to eq('Aspen Glen Site 2')
        expect(updated_campsite.booked_dates).to eq([booking_3.date, booking_4.date])
        expect(updated_campsite.price).to be_a Float
      end
    end

    describe 'request to update a campsite with id that does not exist' do
      it 'returns a 404 status for RecordNotFound' do
        campsite_id = 789
        campsite_params = { name: 'No name' }
        headers = { 'CONTENT_TYPE' => 'application/json'}

        patch "/api/v1/campsites/#{campsite_id}", headers: headers, params: JSON.generate({campsite: campsite_params})

        expect(response.status).to eq(404)
      end

      describe 'request to updated a campsite with invalid parameters' do
        it 'returns a 400 status for RecordInvalid' do
          campsite_id = site_2.id
          previous_name = site_2.name
          expect(previous_name).to eq('2')

          campsite_params = { name: nil }
          headers = { 'CONTENT_TYPE' => 'application/json'}

          patch "/api/v1/campsites/#{campsite_id}", headers: headers, params: JSON.generate({campsite: campsite_params})
          not_updated_campsite = Campsite.find_by(id: campsite_id)

          expect(not_updated_campsite.name).to eq('2')
          expect(response.status).to eq(400)
        end
      end
    end
  end

  describe 'delete /campsites/:id' do
    describe 'request to delete a campsite by existing id' do
      it 'returns a 204 status after finding and deleting campsite' do
        campsite = create(:campsite)

        expect{ delete "/api/v1/campsites/#{campsite.id}" }.to change(Campsite, :count).by(-1)

        expect(response.status).to eq(204)
        expect(response.body).to be_empty
      end

      describe 'request to delete a campsite with invalid id' do
        it 'returns a 404 status for RecordNotFound' do
          id = 999
          delete "/api/v1/campsites/#{id}"
          expect(response.status).to eq(404)
        end
      end
    end
  end
end
