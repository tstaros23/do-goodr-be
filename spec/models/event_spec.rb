require 'rails_helper'

RSpec.describe Event, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :category }
    it { should validate_presence_of :address }
    it { should validate_presence_of :description }
    it { should validate_presence_of :vols_required }
    it { should validate_presence_of :organization_id }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
  end

  describe 'relationships' do
    it { should belong_to(:organization) }
  end

  describe 'model methods' do
    describe '.future_events' do
      it 'returns only events that start in the future' do
        organization = create(:organization)
        event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '11 Revere', description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: "2000-12-31 13:00", end_time: "2022-12-31 14:00")
        event2 = Event.create!(name: 'Soup Kitchen', category: 1, address: '11 Revere', description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: DateTime.now + 1, end_time: "2022-12-31 14:00")

        expect(Event.future_events).to eq([event2])
      end
    end

    describe '.distance_filter', :vcr do
      before do
        organization = create(:organization)
        @event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '1625 Fenton St., Lakewood CO 80214', description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
        @event2 = Event.create!(name: 'Blood Drive', category: 2, address: '5280 Wadsworth Blvd, Arvada CO', description: 'Good blood', vols_required: 1, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
        @event3 = Event.create!(name: 'Homeless Living', category: 2, address: '2136 Champa St, Denver, CO 80205', description: 'Good blood', vols_required: 1, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
      end

      it 'returns only events within distance radius' do
        expect(Event.distance_filter(80001, 5)).to eq([{distance: 0.64, event: @event2}])
      end

      it 'returns events sorted by distance ascending' do
        expect(Event.distance_filter(80001, 10)).to eq([{distance: 0.64, event: @event2}, {distance: 5.542, event: @event1}, {distance: 8.414, event: @event3}])
      end
    end
  end

end
