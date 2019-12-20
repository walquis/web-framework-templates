ENV['RACK_ENV'] = 'test'
require './config/environments'
require 'rack/test'
require 'rspec'
require 'capybara/rspec'
require 'capybara/webkit'
require 'capybara/webkit/matchers'
require 'tilt/erb'
require 'headless'
require 'database_cleaner'
Dir.glob('./spec/helpers/*.rb').each { |f| require f }

Capybara.run_server = true
Capybara.javascript_driver = :webkit
Capybara.default_max_wait_time = 2

require File.expand_path '../../app.rb', __FILE__

# to be include'd in the config a little further down
module RSpecMixin
  include Rack::Test::Methods
  include SpecAppHelper
  def app() SinatraApp end
end

RSpec.configure  do |config|
  headless = nil
  config.before(:all) do
    headless = Headless.new
    headless.start
  end

  config.after(:all) do
    headless.stop
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = false
  end

  config.include RSpecMixin

  config.include(Capybara::Webkit::RspecMatchers, type: :feature)

  config.raise_errors_for_deprecations!

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
