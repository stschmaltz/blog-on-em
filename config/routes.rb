Rails.application.routes.draw do
  resources :tags
  resources :post_likes
  root 'posts#index'

  get 'posts/filter/:filter' => 'posts#index', as: :filtered_posts

  resources :posts do
    resources :comments, only: [:create]
  end

  resource :session, only: %i[new create destroy]

  resources :users
  get 'signup', to: 'users#new'
end
