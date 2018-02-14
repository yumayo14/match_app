Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users do
    collection do
      get 'owner_info'
      get 'service_info'
      post 'card_registrate'
      delete 'card_destroy'
    end
  end
end
