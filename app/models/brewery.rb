class Brewery < ActiveRecord::Base
  extend TopRatings
  include RatingAverage

  validates_presence_of :name
  validates_numericality_of :year, { :greater_than_or_equal_to => 1042,
                                     :only_integer => true }

  validate :year_cannot_be_greater_than_current_year

  has_many :beers
  has_many :ratings, :through => :beers

  scope :active, -> { where(:active => true) }
  scope :retired, -> { where(:active => [nil, false]) }

  def year_cannot_be_greater_than_current_year
    if year > Time.now.year
      errors.add(:year, "cannot be greater than current year")
    end
  end

end
