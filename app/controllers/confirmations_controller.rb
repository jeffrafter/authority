class ConfirmationsController < ApplicationController
  before_filter :login_using_perishable_token

  # Note: this is not an idempotent action, but is required to click the link
  def show      
    @user.confirmed = true
    @user.save!
    Session.create(@user)
    flash[:notice] = "Thanks, your email address has been confirmed."  
    redirect_to dashboard_url  
  end    
  
private  
  def login_using_perishable_token  
    @user = User.find_using_perishable_token(params[:token])
    unless @user  
      flash[:notice] = "We're sorry, but we could not locate your account."
      redirect_to root_url 
      return false
    end  
  end 
end
