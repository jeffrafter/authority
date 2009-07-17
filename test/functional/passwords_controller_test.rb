require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PasswordsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  context "Passwords" do
    should_have_before_filter :login_using_perishable_token_or_current
  end
end
