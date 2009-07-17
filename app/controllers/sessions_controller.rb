class SessionsController < ApplicationController
  before_filter :require_user, :only => :destroy
  skip_before_filter :verify_authenticity_token, :only => :create

  def new
    @session = Session.new
  end
  
  def create
    @session = Session.new(params[:session])
    if @session.save
      flash[:notice] = "Signed in successfully."
      redirect_back_or_default dashboard_url
    elsif @session.errors.on(:password) || @session.errors.on(:email)
      flash.now[:notice] = "Bad email or password."
      render :action => :new, :status => :unauthorized
    elsif @session.attempted_record && !@session.attempted_record.confirmed?
      @session.attempted_record.confirm
      flash.now[:notice] = "User has not confirmed email. Confirmation email will be resent."
      render :action => :new, :status => :unauthorized
    else
      flash.now[:notice] = "Could not sign in."
      render :action => :new, :status => :unauthorized
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "You have been signed out."
    redirect_back_or_default login_url
  end
end