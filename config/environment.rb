# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION
EMAIL_FROM_HOST = "yourdomain.com"
EMAIL_FROM = "donotreply"

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Specify gems that this application depends on and have them installed with 
  # rake gems:install
  config.gem "authlogic"
  config.gem "giraffesoft-resource_controller", :lib => "resource_controller"
  config.gem "javan-whenever", :lib => "whenever"

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  config.frameworks -= [ :active_resource ]

  # Set Time.zone default to the specified zone and make Active Record 
  # auto-convert to this zone. Run "rake -D time" for a list of tasks for 
  # finding time zone names.
  config.time_zone = 'UTC'
end

