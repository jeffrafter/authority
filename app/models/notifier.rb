class Notifier < ActionMailer::Base  
  default_url_options[:host] = EMAIL_FROM_HOST  

  def password_reset(user)  
    subject "Password reset requested"  
    from EMAIL_FROM  
    recipients user.email  
    sent_on Time.now  
    body :url => password_url(:token => user.perishable_token)  
  end  

  def email_confirmation(user)  
    subject "Account confirmation"  
    from EMAIL_FROM  
    recipients user.email  
    sent_on Time.now  
    body :url => confirmation_url(:token => user.perishable_token)  
  end  

end