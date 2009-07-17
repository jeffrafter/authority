require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class SessionsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  context "Sessions" do
    should_have_before_filter :require_user, :only => :destroy
  end
end
