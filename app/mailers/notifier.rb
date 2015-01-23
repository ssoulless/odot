class Notifier < ActionMailer::Base
  default_url_options[:host] = "localhost:3000"
  default from: "from@example.com"

  def password_reset(user)
  	@user = user
  	mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>",
  		 subject: "Reset password")
  end

  def todo_list(todo_list, destination)
  	@user = todo_list.user
  	@todo_list = todo_list
  	mail(to: destination, subject: "#{@user.first_name} sent you a todo list")
  end
end
