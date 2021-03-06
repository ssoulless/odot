require 'spec_helper'

describe "Deleting todo items" do
	let(:user){ todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	let!(:todo_item) { todo_list.todo_items.create(content: %Q|Milk|) }
	
	before do
		sign_in todo_list.user, password: "elarquero"
	end

	it "is successful" do
		visit_todo_list(todo_list)
		click_on todo_item.content
		click_link "Delete"
		expect(page).to have_content(%Q|Todo list item was deleted.|)
		expect(TodoItem.count).to eq(0)
	end
end