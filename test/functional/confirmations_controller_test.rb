require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ConfirmationsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  context "Confirmations" do
    should_have_before_filter :login_using_perishable_token
  end
end
