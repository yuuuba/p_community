Rails.application.routes.draw do
  root to: 'communities#new'
  devise_for :users
  resources :communities
end
