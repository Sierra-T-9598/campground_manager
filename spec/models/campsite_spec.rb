require 'rails_helper'

RSpec.describe Campsite, type: :model do
  describe 'relationships' do
    it { should belong_to(:campground) }
    it { should have_many(:bookings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
  end

  describe 'isntance methods' do
    let!(:campground_1) { create(:campground, name: "Moraine Park") }
    let!(:campground_2) { create(:campground, name: "Arches") }
    let!(:campground_3) { create(:campground, name: "Crater Lake") }

    let!(:site_1) { create(:campsite, campground_id: campground_1.id, name: "1" )}
    let!(:site_2) { create(:campsite, campground_id: campground_1.id, name: "2" ) }
    let!(:site_3) { create(:campsite, campground_id: campground_2.id) }
    let!(:site_4) { create(:campsite, campground_id: campground_2.id) }
    let!(:site_5) { create(:campsite, campground_id: campground_3.id) }
    let!(:site_6) { create(:campsite, campground_id: campground_3.id) }

    let!(:booking_1) { create(:booking, date: '5/6/22', campsite_id: site_1.id) }
    let!(:booking_2) { create(:booking, date: '5/7/22', campsite_id: site_1.id) }
    let!(:booking_3) { create(:booking, date: '5/8/22', campsite_id: site_1.id) }
    let!(:booking_4) { create(:booking, date: '5/6/22', campsite_id: site_2.id) }
    let!(:booking_5) { create(:booking, date: '5/7/22', campsite_id: site_2.id) }
    let!(:booking_6) { create(:booking, date: '5/8/22', campsite_id: site_2.id) }

    describe '#booked_dates' do
      it 'returns the dates that a site is booked' do
        expect(site_1.booked_dates).to eq(['5/6/22', '5/7/22', '5/8/22'])
        expect(site_3.booked_dates).to eq([])
      end
    end

    describe '#booked?(from,to)' do
      it 'returns a boolean if their is a booking matching that dates provided' do
        expect(site_1.booked?(booking_1.date, booking_2.date)).to eq(true)
        expect(site_2.booked?(booking_1.date, booking_2.date)).to eq(true)
        expect(site_3.booked?(booking_1.date, booking_2.date)).to eq(false)
        expect(site_4.booked?(booking_1.date, booking_2.date)).to eq(false)
        expect(site_5.booked?(booking_1.date, booking_2.date)).to eq(false)
        expect(site_6.booked?(booking_1.date, booking_2.date)).to eq(false)
      end
    end
  end
end
