# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logout', type: :feature do
  let(:user) { create(:user) }

  it 'user can logout successfully' do
    login_as(user)

    visit root_path
    click_on user.truncated_email
    click_on 'Logout'

    expect(page).to have_text logged_out_message
  end

  def logged_out_message
    I18n.t('devise.sessions.signed_out')
  end
end
