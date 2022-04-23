# frozen_string_literal: true

Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'home#guest'

  devise_for :users
end
