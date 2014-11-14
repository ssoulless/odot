require "spec_helper"

describe TodoListsController do
  describe "routing" do

    it "routes to #index" do
      get("/todo_lists").should route_to("todo_lists#index")
    end

    it "routes to #new" do
      get("/todo_lists/new").should route_to("todo_lists#new")
    end

    it "routes to #show" do
      get("/todo_lists/1").should route_to("todo_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/todo_lists/1/edit").should route_to("todo_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/todo_lists").should route_to("todo_lists#create")
    end

    it "routes to #update" do
      put("/todo_lists/1").should route_to("todo_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/todo_lists/1").should route_to("todo_lists#destroy", :id => "1")
    end

  end
end
