RailsTutorial::Application.routes.draw do
  root to: 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get 'sign_up', to: 'users#new'
  resources :users, only: [:show, :create]

  get 'sign_in', to: 'sessions#new'
  delete 'sign_out', to: 'sessions#destroy'
  resources :sessions, only: [:create]
  resources :users, only: [:index, :edit, :update]
end
