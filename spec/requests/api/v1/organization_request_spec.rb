require 'rails_helper'

RSpec.describe 'Organization API' do
  describe 'POST /api/v1/organizations' do
    it 'should create a new organization if given valid params' do
      organization_params = {
        name: "Example Organization",
        location: "Denver, CO",
        phone: "555-555-5555",
        email: "example@example.com",
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      created_organization = Event.last

      post '/api/v1/organizations', params: organization_params

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end

  describe 'GET /api/v1/organizations' do
    it "should get a list of organizations" do
      events = create_list(:organization, 3)
      # organization = Organization.create!(name: "ARC", location: "Denver, CO", phone: "555-555-5555", email: "denver@arc.org")
      # organization = Event.create!(name: 'Soup Kitchen', category: 1, address: '11 Revere', description: 'Good food', vols_required: 5, organization_id: organization.id, start_time: "2022-12-31 13:00", duration: 2)
      # organization2 = Event.create!(name: 'Blood Drive', category: 2, address: '12 Colfax', description: 'Good blood', vols_required: 1, organization_id: organization.id, start_time: "2022-12-31 13:00", duration: 2)

      # org = create :organization
      # organization1 = create :organization, { organization: org, address: "5200 Wadsworth Blvd, Arvada CO 80001"}

      get "/api/v1/organizations"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe 'GET /api/v1/organizations/:id' do
    it "should return a single organization" do
      organization = create(:organization)

      get "/api/v1/organizations/#{organization.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH /api/v1/organizations/:id' do
    it "should update an organization" do
      organization = create(:organization)

      organization_params = {
        name: "Edited Org",
      }

      expect(organization.name).to_not eq("Edited Org")

      patch "/api/v1/organizations/#{organization.id}", params: organization_params
      json_organization = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(json_organization[:data][0][:name]).to eq("Edited Org")
    end
  end

  describe 'DELETE /api/v1/organizations/:id' do
    it "should delete an organization" do
      organization = create(:organization)

      delete "/api/v1/organizations/#{organization.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end