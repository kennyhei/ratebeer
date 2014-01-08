class MembershipsController < ApplicationController
  before_filter :ensure_that_signed_in

  def new
    @membership = Membership.new
    @clubs = BeerClub.all
  end

  def create

    user = User.find(user_signed_in?.id)

    if user.beer_clubs.any? { |club| club.id.to_s == params[:membership][:beer_club_id]}
      redirect_to :back, :notice => "User is already a member of this club!"
    else
      membership = Membership.create(membership_params)
      user_signed_in?.memberships << membership

      redirect_to user_path user_signed_in?
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id)
  end
end