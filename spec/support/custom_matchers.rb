# frozen_string_literal: true

RSpec::Matchers.define :require_authentication do
  match do |path|
    visit path

    page.has_current_path?(new_user_session_path) &&
      page.has_text?(unauthenticated_message)
  end

  failure_message do |path|
    <<~MSG
      expected that visiting #{path} would redirect the user to#{' '}
      #{new_user_session_path} and show the message \"#{unauthenticated_message}\"
    MSG
  end
end

# https://stackoverflow.com/a/14769902/2302835
RSpec::Matchers.define :appear_before do |later_content|
  match do |earlier_content|
    page.body.index(earlier_content) < page.body.index(later_content)
  end
end

RSpec::Matchers.define :raise_unauthorized_error do
  match do |given_proc|
    begin
      given_proc.call
    rescue Pundit::NotAuthorizedError
      return true
    end

    false
  end

  supports_block_expectations

  failure_message do
    'expected Pundit::NotAuthorizedError but nothing was raised'
  end
end
