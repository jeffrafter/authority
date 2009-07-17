require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "User" do
    setup do
      @email = 'why@duck.com'
    end
  
    should "make a token and send an email when the user forgets their password" do
      @user = Factory(:confirmed_user, :email => @email)
      assert_delivers_email :subject => 'Password reset requested' do
        token = @user.perishable_token
        @user.forgot_password
        assert_not_equal token, @user.perishable_token
      end  
    end
    
    should "make a token and send an email to confirm the user when created" do
      assert_delivers_email :subject => 'Account confirmation', :to => @email do
        @user = Factory(:user, :email => @email)
        assert_not_nil @user.perishable_token
      end
    end
  end
end
