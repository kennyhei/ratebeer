require 'spec_helper'

describe "Places" do
  include OwnTestHelper

  it "if one is returned by the API, it is shown at the page" do

    # If method is called with argument "kumpula" return following Place-object
    BeermappingAPI.stub(:places_in).with("Kumpula").and_return([ Place.new(:name => "Oljenkorsi") ])
    search_for_places("Kumpula")

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple places are returned by the API, they are all shown at the page" do

    BeermappingAPI.stub(:places_in).with("Jarvenpaa").and_return([ Place.new(:name => "Korona"),
                                                                   Place.new(:name => "Zapata"),
                                                                   Place.new(:name => "Uuno") ])
    search_for_places("Jarvenpaa")

    expect(page).to have_content "Korona"
    expect(page).to have_content "Zapata"
    expect(page).to have_content "Uuno"
  end

  it "if none is returned by the API, a notice is shown at the page" do

    BeermappingAPI.stub(:places_in).with("Savio").and_return([])
    search_for_places("Savio")

    expect(page).to have_content "No locations in Savio"
  end
end