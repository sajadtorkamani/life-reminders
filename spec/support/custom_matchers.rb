# frozen_string_literal: true

module CustomMatchers
  RSpec::Matchers.define :require_authentication do
    match do |given_proc|
      given_proc.call

      page.has_current_path?(new_user_session_path) &&
        page.has_text?(unauthenticated_message)
    end

    supports_block_expectations

    failure_message do
      <<~MSG
        expected a redirect to #{new_user_session_path} and for the message#{' '}
        \"#{unauthenticated_message}\" to be shown.
      MSG
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

  RSpec::Matchers.define :appear_before do |later_content|
    match do |earlier_content|
      earlier_content_index = page.body.index(earlier_content)
      later_content_index = page.body.index(later_content)

      @failure_message = "Expected \"#{earlier_content}\" to appear before \"#{later_content}\""

      def raise_missing_content_error(content)
        @failure_message += " but \"#{content}\" was not found on the page."
        raise RSpec::Expectations::ExpectationNotMetError
      end

      raise_missing_content_error(earlier_content) if earlier_content_index.nil?
      raise_missing_content_error(later_content) if later_content_index.nil?

      earlier_content_index < later_content_index
    end

    failure_message { @failure_message }
  end
end
