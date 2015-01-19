module TodoListHelpers
	def visit_todo_list list
		visit "/todo_lists"
		within dom_id_for(list) do
			click_link list.title
		end
	end
end