class TodoList < ActiveRecord::Base
	has_many :todo_items

	
	validates :title, presence: true
	validates :description, presence: true
	validates :title, length: { minimum: 3 }
	validates :description, length: { minimum: 5 }

	def has_complete_items?
		todo_items.complete.size > 0
	end

	def has_incomplete_items?
		todo_items.incomplete.size > 0
	end
end
