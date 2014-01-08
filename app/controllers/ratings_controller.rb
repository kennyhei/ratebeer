class RatingsController < ApplicationController
  before_filter :ensure_that_signed_in, except: [:index]

  def index
    @most_active_users = User.most_active(3)
    @top_breweries = Brewery.top(3)
    @top_beers = Beer.top(3)
    @top_styles = Style.top(3)
    @recent_ratings = Rating.recent
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create

    # Rating.new "beer_id" => x, "score" => y
    @rating = Rating.new(rating_params)

    if @rating.save
      user_signed_in?.ratings << @rating
      redirect_to user_path user_signed_in?
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if user_signed_in? == rating.user
    redirect_to :back
  end

  private

  def rating_params
    params.require(:rating).permit(:beer_id, :score)
  end
end