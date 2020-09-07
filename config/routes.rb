# frozen_string_literal: true

Rails.application.routes.draw do
  resources :forecasts, only: [:create, :show]
  root 'public#index'
end
