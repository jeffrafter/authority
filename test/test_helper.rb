ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'authlogic/test_case'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures = false
  
  def assert_delivers_email(options, &block) 
     ActionMailer::Base.deliveries.clear
     yield
     assert_not_nil email = ActionMailer::Base.deliveries[0]
     assert email.to.include?(options[:to]) if options[:to]
     assert_equal options[:from], email.from if options[:from]
     assert_equal options[:subject], email.subject if options[:subject]     
     assert_match /#{options[:body]}/i, email.body if options[:body]
  end

  def self.should_have_before_filter(method, options = {}) 
    should "have before filter for #{method}" do
      chain = controller.class.filter_chain.select {|filter| 
        filter.class == ActionController::Filters::BeforeFilter &&
        filter.method == method
      }
      assert_not_equal [], chain
      if options[:only]
        assert_equal 1, chain.size
        assert_not_nil chain.first.options[:only]
        assert_equal options[:only].to_a.map(&:to_s).sort, chain.first.options[:only].sort
      end
      if options[:except]
        assert_equal 1, chain.size
        assert_not_nil chain.first.options[:except]
        assert_equal options[:except].to_a.map(&:to_s).sort, chain.first.options[:except].sort
      end
    end  
  end
  
  def self.should_protect_from_forgery
    should_have_before_filter :verify_authenticity_token
    should "set the authenticity token" do
      assert_equal :authenticity_token, controller.class.request_forgery_protection_token
    end  
  end
  
  def self.should_filter_parameter_logging(options)
    keys = options[:for].map{|k| k.to_s}
    keys.each {|key|     
      should "filter #{key} parameter values from the log" do
        begin
          assert_equal '[FILTERED]', controller.send(:filter_parameters, key => 'secret')[key] 
        rescue
          flunk "Could not filter parameters"
        end  
      end
    }    
  end    
end
