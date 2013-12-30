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

  def favorite_beer
    return nil if ratings.empty? # Return nil if no ratings

    ratings.sort_by { |r| r.score }.last.beer
  end

  def favorite_style
    return nil if ratings.empty?

    style_ratings = calculate_average_ratings_for_styles
    style_ratings.max_by { |style, avg_rating| avg_rating}[0] # Return style with highest avg rating
  end

  def favorite_brewery
    return nil if ratings.empty?

    brewery_ratings = calculate_average_ratings_for_breweries
    brewery_ratings.max_by { |brewery, avg_rating| avg_rating}[0] # Return brewery with highest avg rating
  end

  def calculate_average_ratings_for_breweries
    brewery_group = ratings.group_by { |r| r.beer.brewery }
    calculate_average_ratings brewery_group
  end

  def calculate_average_ratings_for_styles
    style_group = ratings.group_by { |r| r.beer.style }
    calculate_average_ratings style_group
  end

  def calculate_average_ratings(group)
    group.keys.each do |key|
      sum = group[key].inject(0.0) { |sum, rating| sum + rating.score }
      group[key] = sum / group[key].count
    end

    group
  end
end
