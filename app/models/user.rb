class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  # Cannot create multiple users with the same username
  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4
  validates_length_of :username, :minimum => 3, :maximum => 15

  validates :password, :format => { :with => /(?=.*[a-zA-Z])(?=.*[0-9])/,
                                    :message => "must contain numbers and letters"}

  has_many :ratings, :dependent => :destroy # User has many ratings
  has_many :beers, :through => :ratings

  has_many :memberships
  has_many :beer_clubs, :through => :memberships
end
