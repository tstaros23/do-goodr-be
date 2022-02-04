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

      post '/api/v1/events', params: event_params

      expect(response).to be_successful
      expect(response.status).to eq(201)

      event_params_2 = {
        organization_id: organization.id,
        name: "Food Drive",
        category: "Food Service",
        address: "5200 Wadsworth Blvd, Arvada CO 80001",
        description: "Give us your cans",
        vols_required: 50
      }

      post '/api/v1/events', params: event_params_2

      expect(response).to be_successful
      expect(response.status).to eq(201)

      get '/api/v1/events/'
    end
  end
end
