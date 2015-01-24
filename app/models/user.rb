class User < ActiveRecord::Base
	has_secure_password
	has_many :todo_lists

	validates :email, 	presence: true, 
						uniqueness: true,
						format: {
                   		 with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
						}

	before_save :downcase_email

	def downcase_email
		self.email = email.downcase
	end

	def generate_password_reset_token!
		update_attribute :password_reset_token, SecureRandom.urlsafe_base64(48)
	end

	def create_default_lists
		tutorial = todo_lists.find_or_create_by( title: "ODOT Tutorial" )
		tutorial.todo_items.find_or_create_by(content: "Add a todo list or item by clicking the \"+\" button at the top.")
  		tutorial.todo_items.find_or_create_by(content: "The numbers next to a list indicate how many items it has.")
  		tutorial.todo_items.find_or_create_by(content: "Clicking or tapping the list title brings up list items.")
  		tutorial.todo_items.find_or_create_by(content: "Clicking or tapping the list title again gives you more options.")
  		tutorial.todo_items.find_or_create_by(content: "Clicking or tapping a checkmark next to an item marks it complete.")
  		tutorial.todo_items.find_or_create_by(content: "Clicking or tapping it again marks it incomplete.")
  		tutorial.todo_items.find_or_create_by(content: "Clicking or tapping the item lets you edit or delete it.")
	end
end
