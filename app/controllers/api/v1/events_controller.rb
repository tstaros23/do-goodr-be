class Api::V1::EventsController < ApplicationController

  def index
    events = Event.future_events
    render json: EventSerializer.format_multiple(events), status: :ok
  end

  def show
    event = Event.find(params[:id])
    render json: EventSerializer.format_single(event), status: :ok
  end

  def create
    event = Event.create(event_params)
    render json: EventSerializer.format_single(event), status: :created
    # require "pry"; binding.pry
  end

  private

  def event_params
    params.permit(:name, :category, :address, :description, :vols_required, :organization_id, :start_time, :end_time)
  end

end
