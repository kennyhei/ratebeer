module OwnTestHelper
  def sign_in(username, password)
    visit signin_path
    fill_in('username', :with => username)
    fill_in('password', :with => password)
    click_button('Log in')
  end

  def search_for_places(city)
    visit places_path
    fill_in('city', :with => city)
    click_button "Search"
  end
end