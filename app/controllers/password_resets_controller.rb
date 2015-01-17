class PasswordResetsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:email])
		user.generate_password_reset_token!
		redirect_to login_path
	end

end
