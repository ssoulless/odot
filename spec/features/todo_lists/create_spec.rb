require 'spec_helper'

describe "Creating todo lists" do
	let(:user){ create(:user) }

	before do
		sign_in user, password: "elarquero"
	end

	def create_todo_list(options={})
		options[:title] ||= %Q|My todo list|

		visit "/todo_lists"
		click_link "Add Todo List"
		expect(page).to have_content("Add Todo List")
		fill_in "Title", with: options[:title]
		click_button "Save"
	end


	it "redirects to the todo list index page on success" do
		create_todo_list
		expect(page).to have_content(%Q|My todo list|)
	end

	it "displays an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: %Q||

		expect(page).to have_content(/can't be blank/i)
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the todo list has a title less than 3 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: %Q|Hi|

		expect(page).to have_content(/too short/i)
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

end