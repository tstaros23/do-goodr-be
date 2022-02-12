class Api::V1::OrgEventsController < ApplicationController

  def index
    events = Event.organization_filter(params[:organization_id])
    j = render json: EventSerializer.format_multiple(events), status: :ok
  end

end
