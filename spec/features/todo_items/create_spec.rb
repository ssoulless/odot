require 'spec_helper'

describe "Creating todo items" do
	let(:user) { create(:user) }
	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Grocery list description") } 

	before do
		sign_in user, password: "elarquero"
	end
	
	def visit_todo_list list
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end
	end

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: %Q|Milk|
		click_button "Save"
		expect(page).to have_content(%Q|Added todo list item.|)
		within("table.todo_items") do
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