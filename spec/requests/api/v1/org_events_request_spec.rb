require 'rails_helper'

RSpec.describe Api::V1::OrgEventsController, type: :controller  do
  describe 'GET /api/v1/organizations/:organization_id/events' do
    it "should get a list of events" do

      organization = create(:organization)
      create_list(:event, 3, organization: organization)

      get :index, params: { organization_id: organization.id }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
