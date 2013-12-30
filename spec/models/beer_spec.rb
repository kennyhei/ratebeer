require 'spec_helper'

describe Beer do
  it "is not saved if it doesn't have a name" do
    beer = Beer.create :style => "Ale"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved if it doesn't have a style" do
    beer = Beer.create :name => "Karhu"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is saved if it has a name and a style" do
    beer = Beer.create :name => "Karhu", :style => "Lager"

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end
end
