require 'spec_helper'

describe "Deleting todo lists" do
	let(:user){ todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	
	before do
		sign_in todo_list.user, password: "elarquero"
	end

	it "is successful when clicking the destroy link" do
		visit "/todo_lists"

		within "#todo_list_#{todo_list.id}" do
			click_link "Destroy"
		end

		expect(page).to_not have_content(todo_list.title)
		expect(TodoList.count).to eq(0)
	end
end
