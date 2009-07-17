require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  setup :activate_authlogic

  context "A confirmed user" do
    setup do
      @user  = Factory(:confirmed_user, :email => 'why@duck.com')
      @session = Session.new(:email => 'why@duck.com', :password => 'password')
    end
    
    should "be able to create a session" do
      assert @session.valid?
    end
  end
    
  context "An unconfirmed user" do
    setup do
      @user  = Factory(:user, :email => 'why@duck.com')
      @session = Session.new(:email => 'why@duck.com', :password => 'password')
    end
    
    should "not be able to create a session" do
      assert !@session.valid?
    end
  end
end
