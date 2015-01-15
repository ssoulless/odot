module AuthenticationHelpers
	module Controller
		def sign_in(user)
			controller.stub(:require_user).and_return(true)
	#		controller.stub(:user_id).and_return(user.id)
		end
	end

	module Feature
		def sign_in(user, options={})
			visit "/login"
			fill_in "Email", with: user.email
			fill_in "Password", with: options[:password]
			click_button "Log In"
		end
	end
end