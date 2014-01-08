module TopRatings

  def top(n)
    sorted_by_rating_in_desc_order = all.sort_by { |item| -item.average_rating }
    sorted_by_rating_in_desc_order.first(n)
  end
end