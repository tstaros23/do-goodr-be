class Api::V1::OrganizationsController < ApplicationController

  def index
    orgs = Organization.all
    render json: OrganizationSerializer.format_multiple(orgs), status: :ok
  end

  def show
    if Organization.exists?(params[:id])
      org = Organization.find(params[:id])
      render json: OrganizationSerializer.format_single(org), status: :ok
    else
      render json: {errors: {details: "Organization doesnt exist"}}, status: :not_found
    end
  end

  def create
    org = Organization.create(org_params)
    render json: OrganizationSerializer.format_single(org), status: :created
  end

  def update
    if Organization.exists?(params[:id])
      org = Organization.update(params[:id], org_params)
      render json: OrganizationSerializer.format_single(org), status: :ok
    else
      render json: {errors: {details: "Organization doesnt exist"}}, status: :not_found
    end
  end

  def destroy
    if Organization.exists?(params[:id])
      org = Organization.find(params[:id])
      org.destroy
      render json: OrganizationSerializer.format_single(org), status: :ok
    else
      render json: {errors: {details: "Organization doesnt exist"}}, status: :not_found
    end
  end

  private

  def org_params
    params.permit(:name, :location, :phone, :email)
  end
end
