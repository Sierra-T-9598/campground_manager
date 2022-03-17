class Api::V1::CampgroundsController < ApplicationController
  def index
    render json: CampgroundSerializer.new(Campground.all)
  end

  def show
    render json: CampgroundSerializer.new(Campground.find(params[:id]))
  end

  def create
    campground = Campground.create!(campground_params)
    campsites = Campsite.find_by(params[:campground_id])
    campground.campsites << campsites
    render json: CampgroundSerializer.new(campground), status: 201
  end

  def update
    campground = Campground.find(params[:id])
    campground.update!(campground_params)
    render json: CampgroundSerializer.new(campground)
  end

  def destroy
    campground = Campground.find(params[:id])
    campground.delete
  end

  private

  def campground_params
    params.require(:campground).permit(:name)
  end
end
