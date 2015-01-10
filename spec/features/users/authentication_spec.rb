require 'spec_helper'

describe "Logging in" do
	it "logs the user in and goes to the todo lists page" do
		User.create(first_name:"Sebastian", last_name:"Velandia", email: "sebas.velandia@grupo.ly", password:"elarquero", password_confirmation: "elarquero")
		visit new_user_session_path
		fill_in "Email Address", with:"sebas.velandia@grupo.ly"
		fill_in "Password", with:"elarquero"
		click_button "Log In"

		expect(page).to have_content("Todo Lists")
		expect(page).to have_content("Thanks for logging in")
	end

	it "displays the email address in the event of a failed login" do
		visit new_user_session_path
		fill_in "Email Address", with:"sebas.velandia@grupo.ly"
		fill_in "Password", with:"incorrect"
		click_button "Log In"

		expect(page).to have_content("please check your emil and password")
		expect(page).to have_field("Email Address", with: "sebas.velandia@grupo.ly")
	end
end