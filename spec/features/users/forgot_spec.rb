require 'spec_helper'

describe "Forgotten passwords" do
	let!(:user){ create(:user) }

	it "sends a user an email" do
		visit login_path
		click_link "Forgot password?"
		fill_in "Email", with: user.email
		expect {
			click_button "Reset Password"
		}.to change { ActionMailer::Base::deliveries.size }.by(1)
	end

	# it "resets the password when following the email link" do
	# 	visit login_path
	# 	click_link "Forgot password?"
	# 	fill_in "Email", with: user.email
	# 	click_button "Reset Password"
	# 	open_email(user.email)
	# 	current_email.click_link "http://"
	# 	expect(page).to have_content("Update your password")

	# 	fill_in "Password", with: "newpassword"
	# 	fill_in "Password (again)", with: "newpassword"
	# 	click_button "Change password"
	# 	expect(page).to have_content("successfully")
	# 	expect(page.current_path).to eq(todo_lists_path)
	# end
end