require 'spec_helper'

describe "todo_lists/index" do
  before(:each) do
    assign(:todo_lists, [
      stub_model(TodoList,
        :title => "Title"
      ),
      stub_model(TodoList,
        :title => "Title"
      )
    ])
  end

  it "renders a list of todo_lists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "div.todo_list h2", :text => "Title".to_s, :count => 2
  end
end
