class Api::V1::SearchController < ApplicationController

  def index
    begin
      events = Event.distance_filter(params[:zip], params[:distance])
    rescue Event::InvalidZipError
      render json: {errors: {details: "Invalid ZIP code."}}, status: :bad_request
    end
    if events.empty?
      render json: {errors: {details: "No events found"}}, status: :bad_request #Talk to FE about changing to 200series and different language.
    else
      render json: EventSerializer.format_search(events), status: :ok
    end
  end
end
