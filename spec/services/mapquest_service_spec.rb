require 'rails_helper'

RSpec.describe MapquestService, type: :service do
  describe '.route' do
    it 'returns a hash of routes', :vcr do
      expect(MapquestService.route('denver', 'lakewood')).to be_a Hash
      expect(MapquestService.route('denver', 'lakewood')[:route][:distance]).to be_a Float
    end
  end
end
