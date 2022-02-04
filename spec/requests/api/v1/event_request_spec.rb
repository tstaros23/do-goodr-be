require 'rails_helper'

RSpec.describe 'Event API' do
  describe 'POST /api/v1/events' do
    it 'should create a new event if given valid params' do
      organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "555-555-5555", email: "denver@arc.org")
      event_params = {
        organization_id: organization.id,
        name: "Blood Drive",
        category: "Healthcare",
        address: "5200 Wadsworth Blvd, Arvada CO 80001",
        description: "Give us your blood",
        vols_required: 50
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      created_event = Event.last

      post '/api/v1/events', params: event_params

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end

#   xit "should get a list of events" do
#     organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "555-555-5555", email: "denver@arc.org")
#     event = Event.create!()
#     get "/api/v1/events"
#   end
end
