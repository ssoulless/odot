require 'spec_helper'

describe "Editing todo items" do
	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Grocery list description") } 
	let!(:todo_item) { todo_list.todo_items.create(content: %Q|Milk|) }
	def visit_todo_list list
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end
	end

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: %Q|Lots of Milk|
		click_button "Save"
		expect(page).to have_content(%Q|Saved todo list item.|)
		todo_item.reload
		expect(todo_item.content).to eq(%Q|Lots of Milk|)
	end

	it "is unsuccessful with no content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: %Q||
		click_button "Save"
		expect(page).to_not have_content(%Q|Saved todo list item.|)
		expect(page).to have_content(%Q|Content can't be blank|)
		todo_item.reload
		expect(todo_item.content).to eq(%Q|Milk|)
	end

	it "is unsuccessful with no enough content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: %Q|1|
		click_button "Save"
		expect(page).to_not have_content(%Q|Saved todo list item.|)
		expect(page).to have_content(%Q|Content is too short|)
		todo_item.reload
		expect(todo_item.content).to eq(%Q|Milk|)
	end
end