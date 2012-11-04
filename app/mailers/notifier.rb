class Notifier < ActionMailer::Base
  default from: "admin@111items.com"
  
  def notify_frustration_gone(user)
    @user = user
    mail(:to => user.email, :subject => 'Your frustrations are gone')
  end
end
