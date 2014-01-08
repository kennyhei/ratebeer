require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new :username => "Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a proper password" do
    user = User.create :username => "Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved if password is too short" do
    user = User.create :username => "Pekka", :password => "hi1", :password_confirmation => "hi1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved if password contains only letters" do
    user = User.create :username => "Pekka", :password => "pirkka", :password_confirmation => "pirkka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining the favorite_beer" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating 10, user

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with the highest rating if several rated" do
      create_beers_with_ratings 10, 20, 15, 7, 9, user
      best = create_beer_with_rating 25, user

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining the favorite_style" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have a favorite style" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only one rated if only one rating" do
      beer = create_beer_with_rating_and_style 10, "Ale", user
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with the highest average rating" do
      create_beers_with_ratings_and_styles 10, 15, "Lager", user
      create_beers_with_ratings_and_styles 20, 25, "Porter", user
      beer = create_beer_with_rating_and_style 40, "Porter", user

      expect(user.favorite_style).to eq(beer.style)
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining the favorite_brewery" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have a favorite brewery" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only one rated if only one rating" do
      brewery = create_brewery_with_beers_and_ratings "Koff", 10, user
      expect(user.favorite_brewery).to eq(brewery)
    end

    it "is the one with the highest average rating" do
      create_brewery_with_beers_and_ratings "Koff", 5, 10, 15, user
      brewery = create_brewery_with_beers_and_ratings "Malmgard", 20, 25, 30, user

      expect(user.favorite_brewery).to eq(brewery)
    end
  end
end

## Breweries, ratings and styles ##

def create_brewery_with_beers_and_ratings(name, *scores, user)
  brewery = FactoryGirl.create(:brewery, :name => name)
  create_beers_with_ratings_and_brewery brewery, *scores, user
  brewery
end

def create_beers_with_ratings_and_brewery(brewery, *scores, user)
  scores.each do |score|
    beer = create_beer_with_rating score, user
    brewery.beers << beer
  end
end

## Ratings and styles ##

def create_beers_with_ratings_and_styles(*scores, style, user)
  scores.each do |score|
    create_beer_with_rating_and_style score, style, user
  end
end

def create_beer_with_rating_and_style(score, style, user)
  beer = FactoryGirl.create(:beer, :style => FactoryGirl.create(:style, :name => style))
  FactoryGirl.create(:rating, :score => score, :beer => beer, :user => user)
  beer # return beer
end

## Ratings ##

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating score, user
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, :score => score, :beer => beer, :user => user)
  beer # return beer
end