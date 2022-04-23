# frozen_string_literal: true

RSpec.configure do |config|
  config.include Warden::Test::Helpers
end

def login
  user = create(:user)
  login_as(user)
end
