class Rating < ActiveRecord::Base

  validates_numericality_of :score, { :greater_than_or_equal_to => 1,
                                      :less_than_or_equal_to => 50,
                                      :only_integer => true }

  belongs_to :beer
  belongs_to :user # Rating also belongs to user

  # Return 5 most recent ratings
  scope :recent, -> { order(:created_at => :desc).limit(5) }

  def to_s
    "#{beer.name} #{score}"
  end
end
