class Api::V1::OrgEventsController < ApplicationController

  def index
    org = Organization.find(params[:organization_id])
    events = Event.organization_filter(org.id)
    j = render json: EventSerializer.format_multiple(events), status: :ok
  end

end
