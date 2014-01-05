# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create :name => "Koff", :year => 1897
b2 = Brewery.create :name => "Malmgard", :year => 2001
b3 = Brewery.create :name => "Weihenstephaner", :year => 1042

s1 = Style.create :name => "Lager"
s2 = Style.create :name => "Pale ale"
s3 = Style.create :name => "Porter"
s4 = Style.create :name => "Weizen"

a1 = Beer.new :name => "Iso 3"
a2 = Beer.new :name => "Karhu"
a3 = Beer.new :name => "Tuplahumala"
a4 = Beer.new :name => "Huvila Pale ale"
a5 = Beer.new :name => "X Porter"
a6 = Beer.new :name => "Hefezeizen"
a7 = Beer.new :name => "Helles"

s1 << a1
s1 << a2
s1 << a3
s1 << a7
s2 << a4
s3 << a5
s4 << a6

b1.beers << a1
b1.beers << a2
b1.beers << a3
b2.beers << a4
b2.beers << a5
b3.beers << a6
b3.beers << a7