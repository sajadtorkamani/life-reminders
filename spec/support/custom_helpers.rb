# frozen_string_literal: true

module CustomHelpers
  module Capybara
    def fill_in_trix_editor(id, with:)
      find(:css, "##{id}").click.set(with)
    end

    def click_and_confirm(text)
      accept_confirm { click_on(text) }
    end
  end

  module Messages
    def default_form_error_message
      t('simple_form.error_notification.default_message')
    end

    def unauthenticated_message
      t('devise.failure.unauthenticated')
    end
  end

  module ActionMailer
    def sent_emails
      ::ActionMailer::Base.deliveries
    end
  end
end

RSpec.configure do |config|
  config.include CustomHelpers::Messages
  config.include CustomHelpers::Capybara
  config.include CustomHelpers::ActionMailer
end
