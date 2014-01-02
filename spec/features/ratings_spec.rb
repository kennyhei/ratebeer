require 'spec_helper'

describe "Rating" do
  include OwnTestHelper

  let!(:brewery){ FactoryGirl.create :brewery, :name => "Koff" }
  let!(:beer1){ FactoryGirl.create :beer, :name => "Iso 3", :brewery => brewery }
  let!(:beer2){ FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery }
  let!(:user){ FactoryGirl.create :user }

  before :each do
    sign_in 'Pekka', 'foobar1'

    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')
  end

  it "when given, is registered to the beer and user who is signed in" do
    expect{
      click_button 'Create Rating'
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq('15.00')
    expect(brewery.ratings.count).to eq(1)
  end

  it "when given, is listed in the ratings index" do
    click_button 'Create Rating'

    visit ratings_path

    expect(Rating.count).to eq(1)
    expect(page).to have_content('Iso 3 15, rated by Pekka')
  end

  it "when given, is shown in user's page" do
    click_button 'Create Rating'

    visit user_path(user)

    expect(user.ratings.count).to eq(1)
    expect(page).to have_content('has given 1 rating')
    expect(page).to have_content('Iso 3 15')
  end

  it "when user deletes his own rating, it is removed from database" do
    click_button 'Create Rating'

    visit user_path(user)

    expect{
      click_link 'delete'
    }.to change{Rating.count}.from(1).to(0)
  end
end