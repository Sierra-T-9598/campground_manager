require 'rails_helper'

RSpec.describe Campground, type: :model do
  describe 'relationships' do
    it { should have_many(:campsites) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
