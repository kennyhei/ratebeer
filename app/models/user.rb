class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  # Cannot create multiple users with the same username
  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4
  validates_length_of :username, :minimum => 3, :maximum => 15

  validates :password, :format => { :with => /(?=.*[a-zA-Z])(?=.*[0-9])/,
                                    :message => "must contain numbers and letters"}


  # Eager loading time!

  has_many :ratings, :dependent => :destroy, :include => [:beer => [:brewery, :style]]
  has_many :beers, :through => :ratings
  has_many :memberships
  has_many :beer_clubs, :through => :memberships

  def favorite_beer
    return nil if ratings.empty? # Return nil if no ratings
    ratings.sort_by { |r| r.score }.last.beer
  end

  def favorite_style
    calculate_favorite :style
  end

  def favorite_brewery
    calculate_favorite :brewery
  end

  def calculate_favorite(attribute)
    return nil if ratings.empty?

    groups = ratings.group_by { |r| r.beer.send attribute }
    groups = calculate_average_ratings_for groups
    groups.max_by { |key, avg_rating| avg_rating }[0]
  end

  def calculate_average_ratings_for(groups)
    groups.keys.each do |key|
      sum = groups[key].inject(0.0) { |sum, rating| sum + rating.score }
      groups[key] = sum / groups[key].count
    end

    groups
  end

  def self.most_active(n)
    sorted_by_activity = User.all.sort_by { |u| -u.ratings.count }
    sorted_by_activity.first(n)
  end

  def confirmed_member?(club_id)
    membership = Membership.where(:beer_club_id => club_id, :user_id => id).first

    return nil if membership.nil?
    membership.confirmed
  end
end
