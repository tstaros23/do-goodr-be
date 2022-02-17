require 'rails_helper'

RSpec.describe Event, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :category }
    it { should validate_presence_of :address }
    it { should validate_presence_of :description }
    it { should validate_presence_of :phone }
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
        event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '11 Revere', phone: 9287787857, description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: "2000-12-31 13:00", end_time: "2022-12-31 14:00")
        event2 = Event.create!(name: 'Soup Kitchen', category: 1, address: '11 Revere', phone: 9287787857, description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: DateTime.now + 1, end_time: "2022-12-31 14:00")

        expect(Event.future_events).to eq([event2])
      end
    end

    describe '.distance_filter', :vcr do
      before do
        organization = create(:organization)
        @event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '1625 Fenton St., Lakewood CO 80214', phone: 9287787857, description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
        @event2 = Event.create!(name: 'Blood Drive', category: 2, address: '5280 Wadsworth Blvd, Arvada CO', phone: 9287787857, description: 'Good blood', vols_required: 1, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
        @event3 = Event.create!(name: 'Homeless Living', category: 2, address: '2136 Champa St, Denver, CO 80205', phone: 9287787857, description: 'Good blood', vols_required: 1, organization_id: organization.id, start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
      end

      it 'returns only events within distance radius' do
        expect(Event.distance_filter(80001, 5)).to eq([{distance: 0.64, event: @event2}])
        expect(Event.distance_filter(80001, 5)).to_not include(@event3)

      end

      it 'returns events sorted by distance ascending' do
        expect(Event.distance_filter(80001, 10)).to eq([{distance: 0.64, event: @event2}, {distance: 5.542, event: @event1}, {distance: 8.414, event: @event3}])
      end

      it 'returns error if invalid zip' do
        expect{Event.distance_filter(11111, 20)}.to raise_error(Event::InvalidZipError)
      end
    end

    describe '.organization_filter' do
      before do
        @organization1 = create(:organization)
        @organization2 = create(:organization)
        @event1 = create :event, { organization: @organization1 }
        @event2 = create :event, { organization: @organization1 }
        @event3 = create :event, { organization: @organization2 }
      end

      it 'returns only events associated with organization' do
        expect(Event.organization_filter(@organization1.id)).to eq([@event1, @event2])
        expect(Event.organization_filter(@organization1.id)).to_not include(@event3)
      end
    end
  end

end
