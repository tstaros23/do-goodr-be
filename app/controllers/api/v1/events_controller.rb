class Api::V1::EventsController < ApplicationController

  def index
    events = Event.all
    j = render json: EventSerializer.format_get(events), status: :ok
  end

  def create
    event = Event.create(event_params)
    j = render json: EventSerializer.format_new(event), status: :created
    # require "pry"; binding.pry
  end

  private

  def event_params
    params.permit(:name, :category, :address, :description, :vols_required, :organization_id, :start_time, :duration)
  end

end
