require 'spec_helper'

describe TodoItem do
  it { should belong_to(:todo_list) }

  describe "#completed?" do
  	let(:todo_item) { TodoItem.create(content: %Q|Hello|) }

  	it "is false when completed_is blank" do
  		todo_item.completed_at = nil
  		expect(todo_item.completed?).to be_falsey
  	end

  	it "return true when completed_at is not empty" do
  		todo_item.completed_at =  Time.now
  		expect(todo_item.completed?).to be_truthy
  	end
  end
end
