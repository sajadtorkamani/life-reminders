# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :notes, only: %i[index edit update new create]
end
