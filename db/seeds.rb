# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#b1 = Brewery.create :name => "Koff", :year => 1897
#b2 = Brewery.create :name => "Malmgard", :year => 2001
#b3 = Brewery.create :name => "Weihenstephaner", :year => 1042
#
#s1 = Style.create :name => "Lager"
#s2 = Style.create :name => "Pale ale"
#s3 = Style.create :name => "Porter"
#s4 = Style.create :name => "Weizen"
#
#a1 = Beer.new :name => "Iso 3"
#a2 = Beer.new :name => "Karhu"
#a3 = Beer.new :name => "Tuplahumala"
#a4 = Beer.new :name => "Huvila Pale ale"
#a5 = Beer.new :name => "X Porter"
#a6 = Beer.new :name => "Hefezeizen"
#a7 = Beer.new :name => "Helles"
#
#s1.beers << a1
#s1.beers << a2
#s1.beers << a3
#s1.beers << a7
#s2.beers << a4
#s3.beers << a5
#s4.beers << a6
#
#b1.beers << a1
#b1.beers << a2
#b1.beers << a3
#b2.beers << a4
#b2.beers << a5
#b3.beers << a6
#b3.beers << a7

users = 100
breweries = 50
beers_in_brewery = 50
ratings_per_user = 30

(1..users).each do |i|
  User.create :username => "user_#{i}", :password => "passwd1", :password_confirmation => "passwd1"
end

(1..breweries).each do |i|
  Brewery.create :name => "brewery_#{i}", :year => 1900, :active => true
end

bulk = Style.create :name => "bulk", :description => "cheap, not much taste"

Brewery.all.each do |b|
  n = rand(beers_in_brewery)
  (1..n).each do |i|
    beer = Beer.create :name => "beer #{b.id} -- #{i}"
    beer.style = bulk
    b.beers << beer
  end
end

User.all.each do |u|
  n = rand(ratings_per_user)
  beers = Beer.all.shuffle
  (1..n).each do |i|
    r = Rating.new :score => (1+rand(50))
    beers[i].ratings << r
    u.ratings << r
  end
end