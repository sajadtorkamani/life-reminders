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
