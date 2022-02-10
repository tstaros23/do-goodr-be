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
    @event = Event.new(event_params)
    organization = @event.organization
    if @event.save
      EventMailer.with(event: @event, organization: organization).new_event_email.deliver
      render json: EventSerializer.format_single(@event), status: :created
    else
      render json: {errors: {details: "Fill in correct information"}}
    end
  end

  def update
    event = Event.update(params[:id], event_params)
    render json: EventSerializer.format_single(event), status: :ok
  end

  def destroy
    event = Event.destroy(params[:id])
    render json: EventSerializer.format_single(event), status: :ok
  end

  private

  def event_params
    params.permit(:name, :category, :address, :description, :vols_required, :organization_id, :start_time, :end_time)
  end

end
