class UserSessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
	  	session[:user_id] = user.id
	  	flash[:success] = %Q|Thanks for logging in|
	  	redirect_to todo_lists_path
  	else
  		flash[:error] = %Q|Your password or email is incorrect, please check your emil and password|
  		render action: 'new'
  	end
  end
end
	