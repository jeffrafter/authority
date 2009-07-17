require 'test_helper'

class NotifierTest < ActiveSupport::TestCase

  context "A change password email" do
    setup do
      @user  = Factory(:confirmed_user)
      @email = Notifier.create_password_reset @user
    end

    should "set its from address" do
      assert_equal EMAIL_FROM, @email.from[0]
    end

    should "contain a link to edit the user's password" do
      host = ActionMailer::Base.default_url_options[:host]
      regexp = %r{http://#{host}/password\?token=#{@user.perishable_token}}
      assert_match regexp, @email.body
    end

    should "be sent to the user" do
      assert_equal [@user.email], @email.to
    end

    should "set its subject" do
      assert_match /Password reset requested/, @email.subject
    end
  end

  context "A confirmation email" do
    setup do
      @user  = Factory(:user)
      @email = Notifier.create_email_confirmation @user
    end

    should "set its recipient to the given user" do
      assert_equal @user.email, @email.to[0]
    end

    should "set its subject" do
      assert_match /Account confirmation/, @email.subject
    end

    should "set its from address" do
      assert_equal EMAIL_FROM, @email.from[0]
    end

    should "contain a link to confirm the user's account" do
      host = ActionMailer::Base.default_url_options[:host]
      regexp = %r{http://#{host}/confirmation\?token=#{@user.perishable_token}}
      assert_match regexp, @email.body
    end
  end

end
