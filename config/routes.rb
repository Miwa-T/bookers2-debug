Rails.application.routes.draw do
  devise_for :users
  root :to => "homes#top"
  get 'home/about' => 'homes#about'
  get '/search' => 'search#search'
  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :follower_user,:followed_user
    end
    resources :relationships,only: [:create,:destroy]
  end

  resources :books do
    resource :favorites,only: [:create,:destroy]
    resources :book_comments,only: [:create,:destroy]
  end
end