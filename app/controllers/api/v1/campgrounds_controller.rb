class Api::V1::CampgroundsController < ApplicationController
  def index
    if params[:from] && params[:to]
      available_campgrounds = Campground.availability(params[:from], params[:to])
      render json: CampgroundSerializer.new(available_campgrounds)
    elsif params[:order] == 'high_to_low'
      ordered = Campground.price_high_to_low
      render json: CampgroundSerializer.new(ordered)
    elsif params[:order] == 'low_to_high'
      ordered = Campground.price_low_to_high
      render json: CampgroundSerializer.new(ordered)
    else
      render json: CampgroundSerializer.new(Campground.all)
    end
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
