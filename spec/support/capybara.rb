# frozen_string_literal: true

# https://github.com/rspec/rspec-rails/issues/1897
Capybara.configure do |config|
  config.server = :puma, { Silent: true }
  config.javascript_driver = :selenium_chrome_headless
end
