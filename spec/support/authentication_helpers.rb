module AuthenticationHelpers
	def sign_in(user)
		controller.stub(:require_user).and_return(true)
#		controller.stub(:user_id).and_return(user.id)
	end
end