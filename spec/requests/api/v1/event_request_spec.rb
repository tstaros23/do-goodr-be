require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller  do
  describe 'POST /api/v1/events' do
    it 'should create a new event if given valid params' do
      organization = create(:organization)

      event_params = {
        organization_id: organization.id,
        name: "Blood Drive",
        category: "Healthcare",
        address: "5200 Wadsworth Blvd, Arvada CO 80001",
        phone: "555-555-5555",
        description: "Give us your blood",
        vols_required: 50,
        start_time: "2022-12-31 13:00",
        end_time: "2022-12-31 14:00"
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      created_event = Event.last

      post :create, params: event_params

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end

  describe 'GET /api/v1/events' do
    it "should get a list of events" do

      organization = create(:organization)
      create_list(:event, 3, organization: organization)

      get :index

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe 'GET /api/v1/events/:id' do
    it "should return a single event" do
      organization = create(:organization)
      event = create :event, { organization: organization }

      get :index

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH /api/v1/events/:id' do
    it "should update an event" do
      organization = create(:organization)
      event = create :event, { organization: organization }

      event_params = {
        id: event.id,
        name: "Edited Event",
        vols_required: 50,
      }

      expect(event.name).to_not eq("Edited Event")

      patch :update, params: event_params
      json_event = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(json_event[:data][0][:name]).to eq("Edited Event")
    end
  end

  describe 'DELETE /api/v1/events/:id' do
    it "should delete an event" do
      organization = create(:organization)
      event = create :event, { organization: organization }

      delete :destroy, params: {id: event.id}

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
  describe "#create" do
    context "when an event is saved" do
      before  do
        @organization = create(:organization)
        @event_params = {
          organization_id: @organization.id,
          name: "Blood Drive",
          category: "Healthcare",
          address: "5200 Wadsworth Blvd, Arvada CO 80001",
          description: "Give us your blood",
          phone: "555-555-5555",
          vols_required: 50,
          start_time: "2022-12-31 13:00",
          end_time: "2022-12-31 14:00"
        }
      end
      it "sends a confirmation email" do
        expect { post :create, params: @event_params}.to change { ActionMailer::Base.deliveries.count}.by(1)
      end
    end
  end
end
