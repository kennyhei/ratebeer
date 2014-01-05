class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingAPI.places_in(params[:city])

    # Save into session the city
    session[:last_city] = params[:city]

    if @places.empty?
      redirect_to places_path, :notice => "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @scores = BeermappingAPI.scores_in(params[:id])

    places = BeermappingAPI.places_in(session[:last_city])
    places.each do |place|
      return @place = place if place.id == params[:id]
    end
  end
end