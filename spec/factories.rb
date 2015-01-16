FactoryGirl.define do
	factory :user do
		first_name "First"
		last_name "Last"
		sequence(:email) { |n| "user#{n}@odot.com"}
		password "elarquero"
		password_confirmation "elarquero"
	end

	factory :todo_list do
		title "Todo List title"
		description "Todo List description"
		user
	end
end