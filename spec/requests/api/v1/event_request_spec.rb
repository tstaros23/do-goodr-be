require 'rails_helper'

RSpec.describe 'Event API' do
  describe 'POST /api/v1/events' do
    it 'should create a new event if given valid params' do
      organization = create(:organization)

      event_params = {
        organization_id: organization.id,
        name: "Blood Drive",
        category: "Healthcare",
        address: "5200 Wadsworth Blvd, Arvada CO 80001",
        description: "Give us your blood",
        vols_required: 50,
        start_time: "2022-12-31 13:00",
        end_time: "2022-12-31 14:00"
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      created_event = Event.last

      post '/api/v1/events', params: event_params

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end

  describe 'GET /api/v1/events' do
    it "should get a list of events" do

      organization = create(:organization)
      create_list(:event, 3, organization: organization)

      # organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "555-555-5555", email: "denver@arc.org")
      # event = Event.create!(name: 'Soup Kitchen', category: 1, address: '11 Revere', description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: "2022-12-31 13:00", duration: 2)
      # event2 = Event.create!(name: 'Blood Drive', category: 2, address: '12 Colfax', description: 'Good blood', vols_required: 1, organization_id: organization.id, start_time: "2022-12-31 13:00", duration: 2)

      # org = create :organization
      # event1 = create :event, { organization: org, address: "5200 Wadsworth Blvd, Arvada CO 80001"}

      get "/api/v1/events"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe 'GET /api/v1/events/:id' do
    it "should return a single event" do
      organization = create(:organization)
      event = create :event, { organization: organization }

      get "/api/v1/events/#{event.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
