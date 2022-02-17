class Api::V1::EventsController < ApplicationController

  def index
    events = Event.future_events
    render json: EventSerializer.format_multiple(events), status: :ok
  end

  def show
    if Event.exists?(params[:id])
      event = Event.find(params[:id])
      render json: EventSerializer.format_single(event), status: :ok
    else
      render json: {errors: {details: "Event doesnt exist"}}, status: :not_found
    end
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: EventSerializer.format_single(event), status: :created
      NewMailerWorker.perform_async(event.id)
    else
      render json: {errors: {details: "Invalid event details. #{event.errors.full_messages}"}}, status: :bad_request
    end
  end

  def update
    event = Event.find(params[:id])
    if !event.nil? && !params[:organization_id].present?
      updated_event = Event.update(params[:id], event_params)
      render json: EventSerializer.format_single(updated_event), status: :ok
    elsif
      params[:organization_id].present?
      organization = Organization.find(params[:id])
      return  render json: {errors: {details: "Organization doesnt exist"}}, status: :not_found if organization.nil?
    else
      render json: {errors: {details: "Event doesnt exist"}}, status: :not_found
    end
  end

  def destroy
    if Event.exists?(params[:id])
      event = Event.find(params[:id])
      event.destroy
      render json: EventSerializer.format_single(event), status: :ok
    else
      render json: {errors: {details: "Event doesnt exist"}}, status: :not_found
    end
  end

  private

  def event_params
    params.permit(:name, :category, :address, :phone, :description, :vols_required, :organization_id, :start_time, :end_time)
  end
end
