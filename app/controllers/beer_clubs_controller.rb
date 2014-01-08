class BeerClubsController < ApplicationController
  def index
    @clubs = BeerClub.all
  end

  def new
    @club = BeerClub.new
  end

  def create
    club = BeerClub.create(beer_club_params)

    user = current_user

    # User becomes automatically a member of his club
    membership = Membership.create :beer_club_id => club.id, :user_id => user.id, :confirmed => true
    user.memberships << membership

    redirect_to beer_clubs_path
  end

  def show
    @club = BeerClub.find(params[:id])

    @confirmed_members = @club.confirmed_members
    @applicants = @club.applicants

    @membership = Membership.new
    @membership.beer_club = @club
  end

  def destroy
    @club = BeerClub.find(params[:id])

    @club.destroy
    respond_to do |format|
      format.html { redirect_to beer_clubs_path }
      format.json { head :no_content }
    end
  end

  private

  def beer_club_params
    params.require(:beer_club).permit(:name, :founded, :city)
  end
end