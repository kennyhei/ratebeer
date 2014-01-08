module RatingAverage

  def average_rating
    return 0 if ratings.average("score").nil?
    ratings.average("score")
  end
end