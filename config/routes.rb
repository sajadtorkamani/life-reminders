# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#guest'

  devise_for :users

  resources :notes, only: %i[new create]
end
