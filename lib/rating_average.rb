module RatingAverage
  include ActionView::Helpers::NumberHelper

  def average_rating
    number_with_precision(ratings.average("score"), :precision => 2)
  end

end