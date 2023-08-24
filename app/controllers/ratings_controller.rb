class RatingsController < ApplicationController
  include Top
  before_action :fragmentcache_purge, only: %i[create update destroy]

  def index
    @ratings = Rating.all
    @top_beers = top(Beer, 3)
    @top_breweries = top(Brewery, 3)
    @top_styles = top(Style, 3)
    @top_users = top(User, 3)
    @recent_ratings = Rating.recent
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user
    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to ratings_path
  end

  def fragmentcache_purge
    expire_fragment('ratinglist')
  end
end
