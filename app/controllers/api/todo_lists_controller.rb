class Api::TodoListsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def index
		render json: TodoList.all
	end
	def show
		list = TodoList.find(params[:id])
		render json: list
	end
	def create
		list = TodoList.new(list_params)
		if list.save
			head 200
		else
			head 500
		end
	end

	private
	def list_params
		params.require("todo_list").permit("title")
	end
end