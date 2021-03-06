Rails.application.routes.draw do

  root 'posts#index'

  put 'users/:id/add_friend', to: 'users#invite'
  put 'users/:id/confirm_friend', to: 'users#confirm_friend'
  delete 'users/:id/confirm_friend', to: 'users#reject_friend'
  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
