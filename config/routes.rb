Rails.application.routes.draw do

  resources :registered_applications

  devise_for :users
  root to: 'welcome#index'
end
