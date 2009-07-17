# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'shoulda'
require 'shoulda/action_mailer/assertions'
require 'factory_girl'
require 'cucumber/rails/world'

Dir[File.join(RAILS_ROOT, 'test', 'factories', '**', '*')].each {|f| require f }

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures = false
end
 
class Test::Unit::TestCase
  include Shoulda::ActionMailer::Assertions
  
  def me
    @user
  end
end

Test::Unit::TestCase.extend(Shoulda::ActionMailer::Assertions)

ActionMailer::Base.delivery_method = :test

# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'

# Comment out the next line if you don't want transactions to
# open/roll back around each scenario
Cucumber::Rails.use_transactional_fixtures

# Comment out the next line if you want Rails' own error handling
# (e.g. rescue_action_in_public / rescue_responses / rescue_from)
Cucumber::Rails.bypass_rescue

require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end