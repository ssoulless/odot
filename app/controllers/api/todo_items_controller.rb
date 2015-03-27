class Api::TodoItemsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :find_todo_list

	def create
		item = @todo_list.todo_items.new(item_params)
		if item.save
			render status: 200, json: {
				message: "Successfully created todo item.",
				todo_item: item
			}.to_json
		else
			render status: 422, json: {
				message: "Todo Item creation failed",
				errors: item.errors,
			}.to_json
		end
	end

	def update
		item = @todo_list.todo_items.find(params[:id])
		if item.update(item_params)
			render status: 200, json: {
				message: "Successfully updated todo item.",
				todo_item: item
			}.to_json
		else
			render status: 422, json: {
				message: "Todo item update failed.",
				errors: item.errors
			}
		end
	end

	def destroy
		item = @todo_list.todo_items.find(params[:id])
		item.destroy
		render status: 200, json: {
			message: "Successfully destroyed todo item.",
			todo_item: item
		}
	end

	private
	def item_params
		params.require("todo_item").permit("content")
	end
	def find_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end
end