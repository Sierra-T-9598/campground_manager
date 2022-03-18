require 'rails_helper'

RSpec.describe Campground, type: :model do
  describe 'relationships' do
    it { should have_many(:campsites) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  let!(:campground_1) { create(:campground, name: "Moraine Park") }
  let!(:campground_2) { create(:campground, name: "Arches") }
  let!(:campground_3) { create(:campground, name: "Crater Lake") }

  let!(:site_1) { create(:campsite, price: 10.0, campground_id: campground_1.id, name: "1" )}
  let!(:site_2) { create(:campsite, price: 10.0, campground_id: campground_1.id, name: "2" ) }
  # let!(:site_test) { create(:campsite, price: 20.0, campground_id: campground_1.id, name: "test" ) }
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
  let!(:booking_7) { create(:booking, date: '6/9/22', campsite_id: site_3.id) }
  let!(:booking_8) { create(:booking, date: '6/10/22', campsite_id: site_4.id) }

  describe 'instance methods' do
    describe '#booked_dates' do
      it 'returns the dates for each campsite that have a booking and that campsite name' do
        expect(campground_1.booked_dates).to be_an Array
        expect(campground_1.booked_dates).to eq([
                    "[\"5/6/22\", \"5/7/22\", \"5/8/22\"], 1",
                    "[\"5/6/22\", \"5/7/22\", \"5/8/22\"], 2"])
      end
    end

    describe '#lowest_price' do
      it 'returns the lowest price of a campsite' do
        expect(campground_3.lowest_price).to eq(5.0)
      end
    end

    describe '#highest_price' do
      it 'returns the highest price of a campsite' do
        expect(campground_3.highest_price).to eq(8.0)
      end
    end

    describe '#price_range' do
      it 'returns the price range of the campsites at the campground(low to high)' do
        expect(campground_3.price_range).to be_a String
        expect(campground_3.price_range).to eq("$5.0 to $8.0")
      end
    end

    describe '#no_vacancy(from,to)' do
      it 'returns true if all campsites are unavailable for the campground at the given dates' do
        expect(campground_1.no_vacancy?('5/6/22', '5/8/22')).to eq(true)
        expect(campground_2.no_vacancy?('5/6/22', '5/8/22')).to eq(false)
        expect(campground_3.no_vacancy?('5/6/22', '5/8/22')).to eq(false)
      end
    end
  end

  describe 'class methods' do
    describe '::availability(from, to)' do
      it 'returns a list of campgrounds with availability between the given dates' do
        expect(Campground.availability('5/6/22', '5/8/22')).to eq([campground_2, campground_3])
      end
    end

    describe '::price_high_to_low' do
      it 'returns a list of campgrounds ordered highest to lowest price' do
        expect(Campground.price_high_to_low).to eq([campground_1, campground_3, campground_2])
      end
    end

    describe '::price_low_to_high' do
      it 'returns a list of campgrounds ordered lowest to highest price' do
        expect(Campground.price_low_to_high).to eq([campground_2, campground_3, campground_1])
      end
    end
  end
end
