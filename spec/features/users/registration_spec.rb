require 'spec_helper'

describe "Sign Up" do
	it "allows user to sign up for the site and creates the object in database" do
		expect(User.count).to eq(0)
		visit "/"
		expect(page).to have_content("Sign Up")
		click_link "Sign Up"

		fill_in "First name", with: "Sebastian"
		fill_in "Last name", with: "Velandia"
		fill_in "Email", with: "sebas.velandia@grupo.ly"
		fill_in "Password", with: "elarquero27"
		fill_in "Password (again)", with: "elarquero27"
		click_button "Sign Up"

		expect(User.count).to eq(1)
	end

	it "Displays tutorial when user signs up" do
		visit "/"
		expect(page).to have_content("Sign Up")
		click_link "Sign Up"

		fill_in "First name", with: "Sebastian"
		fill_in "Last name", with: "Velandia"
		fill_in "Email", with: "sebas.velandia@grupo.ly"
		fill_in "Password", with: "elarquero27"
		fill_in "Password (again)", with: "elarquero27"
		click_button "Sign Up"

		expect(page).to have_content(%Q|ODOT Tutorial|)
		click_on "ODOT Tutorial"

		expect(page.all("li.todo_item").size).to eq(7)
	end
end