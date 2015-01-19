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

  describe "#toggle_completion!" do
    let(:todo_item){ create(:todo_item) }

    it "updates the completed_at attribute to the current time if nil" do
      todo_item.update_attribute(:completed_at, nil)
      expect{ todo_item.toggle_completion! }.to change{ todo_item.completed_at }
    end

    it "updates the completed_at attribute to nil if already set" do
      todo_item.update_attribute(:completed_at, Time.now)
      expect{ todo_item.toggle_completion! }.to change{ todo_item.completed_at }
      expect(todo_item.completed_at).to be_nil
    end
  end
end
