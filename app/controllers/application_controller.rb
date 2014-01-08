class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Helper methods can be used in views
  helper_method :user_signed_in?, :currently_signed_in?

  def user_signed_in?
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def currently_signed_in?(user)
    user_signed_in? == user
  end

  def ensure_that_signed_in
    redirect_to signin_path, :notice => 'You should be signed in' if user_signed_in?.nil?
  end

  def ensure_that_admin
    redirect_to breweries_path, :notice => "You do not have administrator privileges!" unless user_signed_in?.admin == true
  end
end
