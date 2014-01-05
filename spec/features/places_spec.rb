require 'spec_helper'

describe "Places" do
  include OwnTestHelper

  it "if one is returned by the API, it is shown at the page" do

    # If method is called with argument "kumpula" return following Place-object
    BeermappingAPI.stub(:places_in).with("kumpula").and_return([ Place.new(:id => 1, :name => "Oljenkorsi") ])
    search_for_places("kumpula")

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple places are returned by the API, they are all shown at the page" do

    BeermappingAPI.stub(:places_in).with("jarvenpaa").and_return([ Place.new(:id => 2, :name => "Korona"),
                                                                   Place.new(:id => 3, :name => "Zapata"),
                                                                   Place.new(:id => 4, :name => "Uuno") ])
    search_for_places("jarvenpaa")

    expect(page).to have_content "Korona"
    expect(page).to have_content "Zapata"
    expect(page).to have_content "Uuno"
  end

  it "if none is returned by the API, a notice is shown at the page" do

    BeermappingAPI.stub(:places_in).with("savio").and_return([])
    search_for_places("savio")

    expect(page).to have_content "No locations in savio"
  end
end