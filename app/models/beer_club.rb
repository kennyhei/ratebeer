class BeerClub < ActiveRecord::Base

  validates_uniqueness_of :name

  has_many :memberships, :dependent => :destroy
  has_many :members, :through => :memberships, :source => :user

  def confirmed_members
    Membership.where :beer_club_id => id, :confirmed => true
  end

  def applicants
    Membership.where :beer_club_id => id, :confirmed => [nil, false]
  end

  def is_a_confirmed_member?(user)
    return false if user.nil?

    membership = Membership.where(:beer_club_id => id, :user_id => user.id).first
    return false if membership.nil?
    membership.confirmed
  end

  def is_a_member?(user)
    return false if user.nil?

    members.exists?(user.id)
  end
end
