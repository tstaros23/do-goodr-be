require 'rails_helper'

RSpec.describe MapquestFacade, type: :facade do
  describe '.distance' do
    it 'returns the distance between two points', :vcr do
      expect(MapquestFacade.distance('80001', '5200 Wadsworth Blvd, Arvada CO')).to be_a Float
      expect(MapquestFacade.distance('80001', '5200 Wadsworth Blvd, Arvada CO')).to eq 1.87
    end
  end

  describe '.event_search' do
    it 'returns events and their distances from a zip', :vcr do
      organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "555-555-5555", email: "denver@arc.org")
      event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '1625 Fenton St., Lakewood CO 80214', description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
      event2 = Event.create!(name: 'Blood Drive', category: 2, address: '5280 Wadsworth Blvd, Arvada CO', description: 'Good blood', vols_required: 1, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
      event3 = Event.create!(name: 'Homeless Living', category: 2, address: '2136 Champa St, Denver, CO 80205', description: 'Good blood', vols_required: 1, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")

      expect(MapquestFacade.event_search('80001', 10).count).to eq(3)
      #This is currently a passing test, but something is off--should only be returning 1 if distance is set to 5.
    end
  end
end
