class Api::V1::SearchController < ApplicationController

  def index
    events = Event.distance_filter(params[:zip], params[:distance])
    if events.empty? || events.include?(nil)
      render json: {errors: {details: "No events found"}}, status: :bad_request
    else
      render json: EventSerializer.format_search(events), status: :ok
    end
  end
end
