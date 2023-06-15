Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    resources :comments, only: [:create]
  end

  resources :users
  get 'signup', to: 'users#new'
end
