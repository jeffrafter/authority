class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery 
  filter_parameter_logging :password, :password_confirmation, :token
  helper_method :current_user_session, :current_user

private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = Session.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      render :template => 'sessions/new', :status => :unauthorized
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end