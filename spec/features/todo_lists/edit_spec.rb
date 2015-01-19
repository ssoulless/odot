require 'spec_helper'

describe "Editing todo lists" do
	let(:user){ todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	
	before do
		sign_in todo_list.user, password: "elarquero"
	end

	def update_todo_list options={}
		options[:title] ||= %Q|My todo list|

		todo_list = options[:todo_list]

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		click_button "Update Todo list"
	end

	it "updates a todo list successfully with correct information" do
		pending "Link for edit todo_lists"
		visit "/todo_lists"
		update_todo_list todo_list: todo_list,
						 title: %Q|New title|
		todo_list.reload

		expect(page).to have_content(%Q|Todo list was successfully updated|)
		expect(todo_list.title).to eq(%Q|New title|)
	end

	it "displays an error with no title" do
		pending "Link for edit todo_lists"
		update_todo_list todo_list: todo_list, title: %Q||
		expect(page).to have_content(%Q|error|)
	end

	it "displays an error with too short a title" do
		pending "Link to edit todo_lists"
		update_todo_list todo_list: todo_list, title: %Q|hi|
		expect(page).to have_content(%Q|error|)
	end
end