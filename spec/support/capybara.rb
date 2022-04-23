# frozen_string_literal: true

# frozen_string_literal: true

RSpec.configure do |_config|
  Capybara.javascript_driver = :selenium_chrome_headless

  # config.before(:each, js: true) do
  #   Capybara.page.current_window.resize_to(1366, 768)
  # end
end

def pause
  sleep(100_000)
end
