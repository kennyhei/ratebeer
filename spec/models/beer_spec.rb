require 'spec_helper'

describe Beer do
  let(:style){ FactoryGirl.create(:style) }

  it "is not saved if it doesn't have a name" do
    beer = Beer.create :style => style

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is saved if it has a name and a style" do
    beer = Beer.create :name => "Karhu", :style => style

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end
end
