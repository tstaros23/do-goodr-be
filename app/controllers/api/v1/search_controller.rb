class Api::V1::SearchController < ApplicationController

  def index
    events = Event.distance_filter(params[:zip], params[:distance])
    # require "pry"; binding.pry
  end

end
