class Api::V1::CampsitesController < ApplicationController
  def index
    render json: CampsiteSerializer.new(Campsite.all)
  end

  def show
    render json: CampsiteSerializer.new(Campsite.find(params[:id]))
  end

  def create
    campsite = Campsite.create!(campsite_params)
    render json: CampsiteSerializer.new(campsite), status: 201
  end

  def update
    campsite = Campsite.find(params[:id])
    campsite.update!(campsite_params)
    render json: CampsiteSerializer.new(campsite)
  end

  def destroy
    campsite = Campsite.find(params[:id])
    campsite.delete
  end

  private

  def campsite_params
    params.require(:campsite).permit(:name, :booked_dates, :price, :campground_id)
  end
end
