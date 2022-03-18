class Api::V1::CampgroundCampsitesController < ApplicationController
  def index
    render json: CampsiteSerializer.new(Campground.find(params[:campground_id]).campsites)
  end
end
