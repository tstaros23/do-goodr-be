require 'rails_helper'

RSpec.describe EventSerializer, type: :serializer do

  describe '.format_single' do
    it 'returns a serialized hash' do
      organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "555-555-5555", email: "denver@arc.org")
      event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '1625 Fenton St., Lakewood CO 80214', description: 'Good food', vols_required: 5, organization_id: organization.id, phone: '555-555-5555', start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")

      event_hash = EventSerializer.format_single(event1)

      expect(event_hash).to be_a(Hash)
      expect(event_hash).to have_key(:type)

      expect(event_hash).to have_key(:data)
      expect(event_hash[:data].size).to eq(1)
      expect(event_hash[:data].first).to have_key(:id)
      expect(event_hash[:data].first).to have_key(:organization_id)
      expect(event_hash[:data].first).to have_key(:organization_name)
      expect(event_hash[:data].first).to have_key(:name)
      expect(event_hash[:data].first).to have_key(:category)
      expect(event_hash[:data].first).to have_key(:address)
      expect(event_hash[:data].first).to have_key(:phone)
      expect(event_hash[:data].first).to have_key(:description)
      expect(event_hash[:data].first).to have_key(:vols_required)
      expect(event_hash[:data].first).to have_key(:date)
      expect(event_hash[:data].first).to have_key(:start_time)
      expect(event_hash[:data].first).to have_key(:end_time)

    end
  end

  describe '.format_multiple' do
    it 'returns a serialized hash' do
      organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "555-555-5555", email: "denver@arc.org")
      event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '1625 Fenton St., Lakewood CO 80214', description: 'Good food', vols_required: 5, organization_id: organization.id, phone: '555-555-5555', start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
      event2 = Event.create!(name: 'Blood Drive', category: 2, address: '5280 Wadsworth Blvd, Arvada CO', description: 'Good blood', vols_required: 1, organization_id: organization.id, phone: '555-555-5555', start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
      event3 = Event.create!(name: 'Homeless Living', category: 2, address: '2136 Champa St, Denver, CO 80205', description: 'Good blood', vols_required: 1, organization_id: organization.id, phone: '555-555-5555', start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")

      event_hash = EventSerializer.format_multiple([event1,event2,event3])

      expect(event_hash).to be_a(Hash)
      expect(event_hash).to have_key(:type)

      expect(event_hash).to have_key(:data)
      expect(event_hash[:data].size).to eq(3)
      expect(event_hash[:data].first).to have_key(:id)
      expect(event_hash[:data].first).to have_key(:organization_id)
      expect(event_hash[:data].first).to have_key(:organization_name)
      expect(event_hash[:data].first).to have_key(:name)
      expect(event_hash[:data].first).to have_key(:category)
      expect(event_hash[:data].first).to have_key(:address)
      expect(event_hash[:data].first).to have_key(:phone)
      expect(event_hash[:data].first).to have_key(:description)
      expect(event_hash[:data].first).to have_key(:vols_required)
      expect(event_hash[:data].first).to have_key(:date)
      expect(event_hash[:data].first).to have_key(:start_time)
      expect(event_hash[:data].first).to have_key(:end_time)

    end
  end

  describe '.format_search' do
    it 'returns a serialized hash' do
      organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "555-555-5555", email: "denver@arc.org")
      event1 = Event.create!(name: 'Soup Kitchen', category: 1, address: '1625 Fenton St., Lakewood CO 80214', description: 'Good food', vols_required: 5, organization_id: organization.id, phone: '555-555-5555', start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
      event2 = Event.create!(name: 'Blood Drive', category: 2, address: '5280 Wadsworth Blvd, Arvada CO', description: 'Good blood', vols_required: 1, organization_id: organization.id, phone: '555-555-5555', start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
      event3 = Event.create!(name: 'Homeless Living', category: 2, address: '2136 Champa St, Denver, CO 80205', description: 'Good blood', vols_required: 1, organization_id: organization.id, phone: '555-555-5555', start_time: "2022-12-31 13:00", end_time: "2022-12-31 14:00")
      events = [{distance: 1, event: event1}, {distance: 2, event: event2}, {distance: 3, event: event3}, ]

      event_hash = EventSerializer.format_search(events)

      expect(event_hash).to be_a(Hash)
      expect(event_hash).to have_key(:type)

      expect(event_hash).to have_key(:data)
      expect(event_hash[:data].size).to eq(3)
      expect(event_hash[:data].first).to have_key(:distance)
      expect(event_hash[:data].first).to have_key(:id)
      expect(event_hash[:data].first).to have_key(:organization_id)
      expect(event_hash[:data].first).to have_key(:organization_name)
      expect(event_hash[:data].first).to have_key(:name)
      expect(event_hash[:data].first).to have_key(:category)
      expect(event_hash[:data].first).to have_key(:address)
      expect(event_hash[:data].first).to have_key(:phone)
      expect(event_hash[:data].first).to have_key(:description)
      expect(event_hash[:data].first).to have_key(:vols_required)
      expect(event_hash[:data].first).to have_key(:date)
      expect(event_hash[:data].first).to have_key(:start_time)
      expect(event_hash[:data].first).to have_key(:end_time)

    end
  end

end
