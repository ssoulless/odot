module ApplicationHelper
	def new_item_link
		#<a href="#" class="icon-new right hide-text">Add Item</a>
		if @todo_list && !@todo_list.new_record?
			text = "Todo Item"
			path = new_todo_list_todo_item_path(@todo_list)
		else
			text = "Todo List"
			path = new_todo_list_path
		end

		link_to "Add #{text}", path, class: "icon-new right hide-text"
	end
end
