class User < ActiveRecord::Base
  acts_as_authentic
  after_create :confirm
#  validates_uniqueness_of :email
#  validates_confirmation_of :password
  
  def forgot_password
    reset_perishable_token!
    Notifier.deliver_password_reset(self)  
  end
  
  def confirm
    reset_perishable_token!
    Notifier.deliver_email_confirmation(self)  
  end
end
