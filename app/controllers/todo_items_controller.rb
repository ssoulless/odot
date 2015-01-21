class TodoItemsController < ApplicationController
  before_action :require_user
  before_action :find_todo_list
  before_action :set_back_link, except: [:index]

  def index
    go_back todo_lists_path
  end

  def new
  	@todo_item = @todo_list.todo_items.new
  end

  def create
  	@todo_item = @todo_list.todo_items.new(todo_item_params)
  	if @todo_item.save
  		flash[:success] = %Q|Added todo list item.|
  		redirect_to todo_list_todo_items_path
  	else
  		flash[:error] = %Q|There was a problem adding that todo list item.|
  		render action: :new
  	end
  end

  def edit
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def update
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = %Q|Saved todo list item.|
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = %Q|That todo item could not be saved.|
      render action: :edit
    end
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = %Q|Todo list item was deleted.|
    else
      flash[:error] = %Q|Todo list item could not be deleted.|
    end
    redirect_to todo_list_todo_items_path
  end

  def complete
     @todo_item = @todo_list.todo_items.find(params[:id])
     @todo_item.toggle_completion!
     redirect_to todo_list_todo_items_path, notice: %Q|Todo item updated.|
  end

  def url_options
    { todo_list_id: params[:todo_list_id] }.merge(super)
  end

  private
  def find_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def todo_item_params
  	params[:todo_item].permit(:content)
  end

  def set_back_link
    go_back todo_list_todo_items_path(@todo_list)
  end
end
