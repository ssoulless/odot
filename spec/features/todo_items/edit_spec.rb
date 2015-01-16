require 'spec_helper'

describe "Editing todo items" do
	let(:user){ todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	let!(:todo_item) { todo_list.todo_items.create(content: %Q|Milk|) }
	
	before do
		sign_in todo_list.user, password: "elarquero"
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