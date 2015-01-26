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
		click_link todo_list.title
		click_link "Edit"

		fill_in "Title", with: options[:title]
		click_button "Save"
	end

	it "updates a todo list successfully with correct information" do
		visit "/todo_lists"
		update_todo_list todo_list: todo_list,
						 title: %Q|New title|
		todo_list.reload

		expect(page).to have_content(%Q|Todo list was successfully updated|)
		expect(todo_list.title).to eq(%Q|New title|)
	end

	it "displays an error with no title" do
		update_todo_list todo_list: todo_list, title: %Q||
		expect(page).to have_content(/can't be blank/i)
	end

	it "displays an error with too short a title" do
		update_todo_list todo_list: todo_list, title: %Q|hi|
		expect(page).to have_content(/is too short/i)
	end
end