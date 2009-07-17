Given /^a registered user with the email "(.*)" with password "(.*)" exists$/ do |email, password|
  @user = Factory(:user, :email => email, :password => password, :password_confirmation => password)
end

Given /^a confirmed user with the email "(.*)" with password "(.*)" exists$/ do |email, password|
  @user = Factory(:confirmed_user, :email => email, :password => password, :password_confirmation => password)
end

Given /^no current user$/ do
  get "/logout"
  @user = nil
end

Then /^the login form should be shown$/ do
  assert_template "sessions/new"
end

Then /^I should\s?((?:not)?) be authorized$/ do |present|
  assert_response present ? :unauthorized : :success
end

Then /^I should\s?((?:not)?) be signed in$/ do |present|
  assert_equal(present.blank?, controller.send(:current_user).present?) if controller
end