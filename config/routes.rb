Rails.application.routes.draw do

  resources :registered_applications
  resources :applications

  devise_for :users
  root to: 'welcome#index'
end
