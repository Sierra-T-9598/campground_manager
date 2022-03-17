class Api::V1::CampgroundCampsitesController < ApplicationController
  def index
  end

  def show
  end

  def create
    campground = Campground.find_by(params[:campground_id])
    campsite = Campsite.create!(campsite_params)
    campground << campsite
    render json: CampsiteSerializer.new(campsite), status: 201
  end

  def update
    campsite = Campsite.find(params[:id])
    campsite.update!(campsite_params)
    render json: CampsiteSerializer.new(campsite)
  end

  def destroy
  end
end
