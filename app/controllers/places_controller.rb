class PlacesController < ApplicationController
  def index
  end

  def search
    @weather = WeatherstackApi.get_weather(params[:city])
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_city] = params[:city]
      render :index, status: 418
    end
  end

  def show
    @place = BeermappingApi.places_in(session[:last_city]).find { |p| p.id == params[:id] }
    @weather = WeatherstackApi.get_weather(session[:last_city])
  end
end
