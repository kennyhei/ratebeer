class Style < ActiveRecord::Base
  extend TopRatings
  include RatingAverage

  validates_presence_of :name

  has_many :beers
  has_many :ratings, :through => :beers
end
