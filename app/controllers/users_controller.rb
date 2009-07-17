class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :update]
  resource_controller 

  def object
    @user = @current_user || User.new
  end    

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Thanks for signing up, you will receive an email in the next few minutes with instructions for completing your registration."
      redirect_back_or_default '/'
    else
      render :action => :new
    end
  end
end
