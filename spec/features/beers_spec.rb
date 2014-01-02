require 'spec_helper'

describe "Beer" do
  include OwnTestHelper

  let!(:brewery){ FactoryGirl.create :brewery, :name => "Koff" }
  let!(:user){ FactoryGirl.create :user }

  before :each do
    sign_in 'Pekka', 'foobar1'
  end

  it "when created by user, it is saved to database" do
    visit new_beer_path

    fill_in('beer_name', :with => 'Karhu')
    select('Lager', :from => 'beer[style]')
    select(brewery.name, :from => 'beer[brewery_id]')

    expect{
      click_button 'Create Beer'
    }.to change{Beer.count}.from(0).to(1)
  end
end