require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'relationships' do
    it { should belong_to(:campsite) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
  end
end
