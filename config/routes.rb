Rails.application.routes.draw do
  # devise_for :users,
  #   controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users
  # resources :home, only: [:index, :show]
  root "users#index"
end
