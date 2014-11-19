require 'spec_helper'

describe "Viewing todo items" do
	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Grocery list description") } 

	it "displays the title of the todo list" do
		visit_todo_list(todo_list)
		within("h1.todo-list-tile") do
			expect(page).to have_content(todo_list.title)
		end	
	end

	it "displays no items when a todo list is empty" do
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(0)
	end

	it "displays item content when a todo list has items" do
		todo_list.todo_items.create(content: %Q|Milk|)	
		todo_list.todo_items.create(content: %Q|Eggs|)	

		visit_todo_list(todo_list)

		expect(page.all("table.todo_items tr").size).to eq(2)
		within "ul.todo_items" do
			expect(page).to have_content(%Q|Milk|)
			expect(page).to have_content(%Q|Eggs|)
		end
	end

end