class BeerClubsController < ApplicationController
  def index
    @clubs = BeerClub.all
  end

  def new
    @club = BeerClub.new
  end

  def create
    BeerClub.create(beer_club_params)

    redirect_to beer_clubs_path
  end

  def show
    @club = BeerClub.find(params[:id])
    @membership = Membership.new
    @membership.beer_club = @club
  end

  private

  def beer_club_params
    params.require(:beer_club).permit(:name, :founded, :city)
  end
end