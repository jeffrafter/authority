class PasswordsController < ApplicationController
  before_filter :login_using_perishable_token_or_current, :only => [:show, :update]
  resource_controller
  actions :show, :update
  
  def forgot
  end
  
  def reset
    if @user = User.find_by_email(params[:email])
      @user.forgot_password
      flash[:notice] = "An email has been sent your address with instructions for resetting your password."
      redirect_to login_url
    else
      flash[:notice] = "Could not find a user with that email address."  
      render :action => :forgot
    end
  end
  
  def update  
    @user.password = params[:user][:password]  
    @user.password_confirmation = params[:user][:password_confirmation]  
    if @user.save  
      flash[:notice] = "Password successfully updated."  
      redirect_to account_url  
    else  
      render :action => :show
    end  
  end    

private
  def login_using_perishable_token_or_current  
    @user = User.find_using_perishable_token(params[:token]) || current_user
    unless @user  
      flash[:notice] = "We're sorry, but we could not locate your account."
      redirect_to root_url 
      return false
    end  
  end    
end
