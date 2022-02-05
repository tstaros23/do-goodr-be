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
    it { should validate_presence_of :duration }
  end

  describe 'relationships' do
    it { should belong_to(:organization) }
  end

  describe 'model methods' do
    describe '.future_events' do
      it 'returns only events that start in the future' do
        organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "555-555-5555", email: "denver@arc.org")
        event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '11 Revere', description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: "2000-12-31 13:00", duration: 2)
        event2 = Event.create!(name: 'Soup Kitchen', category: 1, address: '11 Revere', description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: DateTime.now + 1, duration: 2)

        expect(Event.future_events).to eq([event2])
      end
    end
  end

end
