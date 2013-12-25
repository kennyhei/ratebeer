class Beer < ActiveRecord::Base

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  def average_rating

    # Inject way
    #sum = ratings.inject(0.0) do |result, rating|
    #  result + rating.score
    #end

    # return average
    #sum / ratings.count

    # Easy way
    ratings.average("score")
  end

  def to_s
    "#{name} (#{brewery.name})"
  end
end
