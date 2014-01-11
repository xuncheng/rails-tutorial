RailsTutorial::Application.routes.draw do
  root to: 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get 'sign_up', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  delete 'sign_out', to: 'sessions#destroy'
  resources :users do
    get 'following', on: :member
    get 'followers', on: :member
  end
  resources :sessions, only: [:create]
  resources :microposts, only: [:create, :destroy]
end
