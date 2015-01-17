class Notifier < ActionMailer::Base
  default_url_options[:host] = "localhost:3000"
  default from: "from@example.com"

  def password_reset(user)
  	@user = user
  	mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>",
  		 subject: "Reset password")
  end
end
