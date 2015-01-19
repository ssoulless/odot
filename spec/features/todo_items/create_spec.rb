require 'spec_helper'

describe "Creating todo items" do
	let(:user){ todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	
	before do
		sign_in todo_list.user, password: "elarquero"
	end

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: %Q|Milk|
		click_button "Save"
		expect(page).to have_content(%Q|Added todo list item.|)
		within(".todo-items") do
			expect(page).to have_content(%Q|Milk|)
		end
	end

	it "displays an error with no content" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: ""
		click_button "Save"
		within("div.flash") do
			expect(page).to have_content(%Q|There was a problem adding that todo list item.|)
		end
		expect(page).to have_content(%Q|Content can't be blank|)
	end	

	it "displays an error with content less than 2 characters long" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: "1"
		click_button "Save"
		within("div.flash") do
			expect(page).to have_content(%Q|There was a problem adding that todo list item.|)
		end
		expect(page).to have_content(%Q|Content is too short|)
	end	
	
end