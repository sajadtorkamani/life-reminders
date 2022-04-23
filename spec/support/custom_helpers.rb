# frozen_string_literal: true

def default_form_error_message
  I18n.t('simple_form.error_notification.default_message')
end

def unauthenticated_message
  I18n.t('devise.failure.unauthenticated')
end