require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class TestsController < ApplicationController
  before_filter :require_user  
  def show
    render :nothing => true
  end
end

class ApplicationControllerTest < ActionController::TestCase
  setup :activate_authlogic

  context "Application" do
    should_protect_from_forgery
    should_filter_parameter_logging :for => [:password, :password_confirmation, :token]
    
    context "with user logged in" do
      setup do
        @user = Factory(:confirmed_user)       
        Session.create(@user)
      end
      
      should "find the current session" do
        assert_equal @user, controller.send(:current_user_session).user
      end
      
      should "find the current user" do
        assert_equal @user, controller.send(:current_user)
      end

      should "not show the login page if a user is required" do
        controller.send(:require_user)
        assert_response :success  
      end      
    end
    
    context "with no user logged in" do
      should "not find the current session" do
        assert_nil controller.send(:current_user_session)
      end

      should "not find the current user" do
        assert_nil controller.send(:current_user)
      end
    end  
    
    should "redirect to the stored location" do
      controller.stubs(:session).returns(:return_to => '/muppets')
      controller.expects(:redirect_to).with('/muppets')
      controller.send(:redirect_back_or_default, '/donkeys')
    end
    
    should "redirect to the default location if there is no stored location" do
      controller.stubs(:session).returns(:return_to => nil)
      controller.expects(:redirect_to).with('/donkeys')
      controller.send(:redirect_back_or_default, '/donkeys')
    end
    
  end  
  
  context "Test" do
    setup do
      ActionController::Routing::Routes.add_named_route('test', '/test', :controller => 'tests', :action => 'show')
      @controller = TestsController.new
    end

    should "be unauthorized and show the login if no user is logged in" do
      get :show
      assert_response :unauthorized
      assert_template 'sessions/new'
      assert_not_nil session[:return_to]      
    end
      
    should "not show the login if a user is logged in" do
      Session.create(Factory(:confirmed_user))
      get :show
      assert_response :success
    end      
  end
end