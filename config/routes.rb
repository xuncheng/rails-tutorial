RailsTutorial::Application.routes.draw do
  root to: 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
  resources :users do
    get 'following', on: :member
    get 'followers', on: :member
  end
  resources :sessions, only: [:create]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
