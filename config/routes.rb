Rails.application.routes.draw do
  root "home#index"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}

  resources :users do
    collection do
      post 'card_registrate'
      delete 'card_destroy'
    end
  end
end
