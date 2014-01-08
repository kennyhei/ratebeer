require 'spec_helper'

describe "User" do
  include OwnTestHelper

  describe "who signs up" do

    it "when signed up with good credentials, user is added to the system" do
      visit signup_path

      fill_in('user_username', :with => 'Brian')
      fill_in('user_password', :with => 'secret55')
      fill_in('user_password_confirmation', :with => 'secret55')

      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end

  describe "who has signed up" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it "can sign in with right credentials" do
      sign_in 'Pekka', 'foobar1'

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to sign in form if wrong credentials given" do
      sign_in 'Pekka', 'wrong'

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and password do not match'
    end

    it "doesn't have a favorite style, if user hasn't made any ratings" do
      visit user_path(@user)

      expect(page).not_to have_content 'Favorite style:'
    end

    it "doesn't have a favorite brewery, if user hasn't made any ratings" do
      visit user_path(@user)

      expect(page).not_to have_content 'Favorite brewery:'
    end

    it "has a favorite style, when one or more ratings" do
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, :score => 15, :beer => beer, :user => @user)

      sign_in 'Pekka', 'foobar1'

      expect(page).to have_content 'Preferred style: Lager'
    end

    it "has a favorite brewery, when one or more ratings" do
      brewery = FactoryGirl.create(:brewery)
      beer = FactoryGirl.create(:beer, :brewery => brewery)
      FactoryGirl.create(:rating, :score => 20, :beer => beer, :user => @user)

      sign_in 'Pekka', 'foobar1'

      expect(page).to have_content 'Favorite brewery: anonymous'
    end
  end
end