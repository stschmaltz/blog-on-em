Rails.application.routes.draw do
  root 'posts#index'

  get 'posts', to: 'posts#index'
  get 'posts/:id', to: 'posts#show', as: 'post'
  get 'posts/:id/edit', to: 'posts#edit', as: 'edit_post'
end
