require 'capybara'
require 'capybara/rspec'
require 'capybara/webkit'
require 'factory_girl_rails'
require 'support/factory_girl'
require 'support/database_cleaner'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

Capybara::Webkit.configure do |config|
  # Allow pages to make requests to any URL without issuing a warning.
  config.allow_unknown_urls
end
