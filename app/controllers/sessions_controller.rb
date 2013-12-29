class SessionsController < ApplicationController

  def new
    # Render login page (sessions/new)
  end

  def create
    # Find user from db
    user = User.find_by_username params[:username]

    if user.nil? or not user.authenticate params[:password]
      redirect_to :back, :notice => "Username and password do not match!"
    else
      # Save user id into session (if user exists)
      session[:user_id] = user.id
      redirect_to user_path(user), :notice => "Welcome back!"
    end
  end

  def destroy
    # Clear session
    session[:user_id] = nil

    redirect_to :root
  end

end