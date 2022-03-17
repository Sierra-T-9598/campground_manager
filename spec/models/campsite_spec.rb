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


end
