require 'spec_helper'

describe "Viewing todo items" do
	let(:user){ todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	
	before do
		sign_in todo_list.user, password: "elarquero"
	end

	it "displays the title of the todo list" do
		visit_todo_list(todo_list)
		within("h2.page-title") do
			expect(page).to have_content(todo_list.title)
		end	
	end

	it "displays no items when a todo list is empty" do
		visit_todo_list(todo_list)
		expect(page.all("ul.todo-items li").size).to eq(0)
	end

	it "displays item content when a todo list has items" do
		todo_list.todo_items.create(content: %Q|Milk|)	
		todo_list.todo_items.create(content: %Q|Eggs|)	

		visit_todo_list(todo_list)

		expect(page.all("ul.todo-items li").size).to eq(2)
		within "ul.todo-items" do
			expect(page).to have_content(%Q|Milk|)
			expect(page).to have_content(%Q|Eggs|)
		end
	end

end