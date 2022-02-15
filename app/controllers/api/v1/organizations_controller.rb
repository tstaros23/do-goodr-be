class Api::V1::OrganizationsController < ApplicationController

  def index
    orgs = Organization.all
    render json: OrganizationSerializer.format_multiple(orgs), status: :ok
  end

  def show
    org = Organization.find(params[:id])
    render json: OrganizationSerializer.format_single(org), status: :ok
  end

  def create
    org = Organization.create(org_params)
    render json: OrganizationSerializer.format_single(org), status: :created
  end

  def update
    org = Organization.update(params[:id], org_params)
    render json: OrganizationSerializer.format_single(org), status: :ok
  end

  def destroy
    org = Organization.destroy(params[:id])
    render json: OrganizationSerializer.format_single(org), status: :ok
  end

  private

  def org_params
    params.permit(:name, :location, :phone, :email)
  end
end
