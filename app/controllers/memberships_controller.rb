class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
    @clubs = BeerClub.all
  end

  def create

    user = User.find(current_user.id)

    if user.beer_clubs.any? { |club| club.id.to_s == params[:membership][:beer_club_id]}
      redirect_to :back, :notice => "User is already a member of this club!"
    else
      membership = Membership.create(membership_params)
      current_user.memberships << membership

      redirect_to user_path current_user
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id)
  end
end