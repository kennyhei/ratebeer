class Beer < ActiveRecord::Base
  include RatingAverage

  validates_presence_of :name

  belongs_to :brewery
  belongs_to :style

  has_many :ratings, :dependent => :destroy
  has_many :raters, :through => :ratings, :source => :user

  def to_s
    "#{name} (#{brewery.name})"
  end
end
