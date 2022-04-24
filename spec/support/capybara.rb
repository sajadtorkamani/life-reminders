# frozen_string_literal: true

# frozen_string_literal: true

RSpec.configure do
  Capybara.javascript_driver = :selenium_chrome_headless
end

# https://github.com/rspec/rspec-rails/issues/1897
Capybara.configure do |config|
  config.server = :puma, { Silent: true }
end

def pause
  sleep(100_000)
end
