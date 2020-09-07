# frozen_string_literal: true

Rails.application.routes.draw do
  resources :forecasts, only: %i[create show]
  root 'public#index'
end
