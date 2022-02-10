class Api::V1::SessionsController < ApplicationController

  def create
    org = Organization.find_by(email: params[:email].downcase)
    if org
      render json: OrganizationSerializer.serialize(org)
    else
      render json: { errors: { details: 'Organization not found' } }, status: 401
    end
  end
