class BeermappingAPI

  def self.places_in(city)
    Place # Ensures that class is loaded

    city = city.downcase

    # Cache unless already cached
    if not Rails.cache.exist? city
      Rails.cache.write(city, fetch_places_in(city), :expires_in => 1.hour)
    end

    Rails.cache.read city
  end

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get("#{url}#{city.gsub(' ', '%20')}")
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)

    # Convert hash array into Place-object array
    return places.inject([]) do |set, location|
      set << Place.new(location)
    end
  end

  def self.scores_in(location)
    Place # Ensures that class is loaded

    # Cache unless already cached
    if not Rails.cache.exist? location
      Rails.cache.write(location, fetch_scores_in(location), :expires_in => 1.hour)
    end

    Rails.cache.read location
  end

  def self.fetch_scores_in(location)
    url = "http://beermapping.com/webservice/locscore/#{key}/"

    response = HTTParty.get("#{url}#{location}")
    scores = response.parsed_response["bmp_locations"]["location"]

    scores
  end

  def self.key
    Settings.beermapping_apikey
  end
end