class Api::V1::SearchController < ApplicationController

  def index
    events = Event.distance_filter(params[:zip], params[:distance])
    j = render json: EventSerializer.format_search(events), status: :ok
  end
end
