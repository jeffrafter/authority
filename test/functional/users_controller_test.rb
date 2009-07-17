require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic
  context "Users" do
    should_have_before_filter :require_user, :only => [:show, :update]
  end
end
