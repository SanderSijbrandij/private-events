Rails.application.routes.draw do
  root to: 'events#index'
  resources :users,  only: [:new, :create, :index, :show]
  resources :events, only: [:new, :create, :index, :show]

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
