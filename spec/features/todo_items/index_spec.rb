require 'spec_helper'

describe "Viewing todo items" do
	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Grocery list description") } 
	it "displays no items when a todo list is empty" do
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "List Items"
		end
		expect(page).to have_content(%Q|TodoItems#index|)
	end
end