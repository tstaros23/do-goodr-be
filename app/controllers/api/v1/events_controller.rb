class Api::V1::EventsController < ApplicationController

  def index
    events = Event.all
    j = render json: EventSerializer.format_json(events), status: 201
  end

  def create
    event = Event.create(event_params)
    render json: EventSerializer.format_json(event), status: 201
  end

  private

  def event_params
    params.permit(:name, :category, :address, :description, :vols_required, :organization_id)
  end

end
