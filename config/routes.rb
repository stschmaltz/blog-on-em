Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    resources :comments, only: [:create]
  end

  resource :session, only: %i[new create destroy]

  resources :users
  get 'signup', to: 'users#new'
end
