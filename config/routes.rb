# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :notes, except: :show
  resources :reminders, only: %i[index new create]
end
