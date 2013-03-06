class SessionsController < ApplicationController
  def index
  end

  def new
  end

  def create
	user = User.authenticate(params[:email], params[:password])
	if user
		session[:user_id] = user.id
		redirect_to pages_newsfeed_path
	else
		flash.now.alert = "Invalid email or password"
		render "new"
	end
  end

  def destroy
	session[:user_id] = nil
	flash.now.alert = "Invalid email or password"
	redirect_to new_session_path
  end
end
