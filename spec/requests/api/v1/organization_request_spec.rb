require 'rails_helper'

RSpec.describe Api::V1::OrganizationsController, type: :controller do
  describe 'POST /api/v1/organizations' do
    it 'should create a new organization if given valid params' do
      organization_params = {
        name: "Example Organization",
        location: "Denver, CO",
        phone: "928-779-7857",
        email: "example@example.com",
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      created_organization = Event.last

      post :create, params: organization_params

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end

  describe 'GET /api/v1/organizations' do
    it "should get a list of organizations" do
      events = create_list(:organization, 3)
      get :index

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe 'GET /api/v1/organizations/:id' do
    it "should return a single organization" do
      organization = create(:organization)

      get :show, params: { id: organization.id}

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH /api/v1/organizations/:id' do
    it "should update an organization" do
      organization = create(:organization)

      organization_params = {
        id: organization.id,
        name: "Edited Org",
      }

      expect(organization.name).to_not eq("Edited Org")

      patch :update, params: organization_params
      json_organization = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(json_organization[:data][0][:name]).to eq("Edited Org")
    end
  end

  describe 'DELETE /api/v1/organizations/:id' do
    it "should delete an organization" do
      organization = create(:organization)

      delete :destroy, params: {id: organization.id}

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
