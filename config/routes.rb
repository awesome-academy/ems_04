Rails.application.routes.draw do
  root "static_pages#home"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/help", to: "static_pages#help"

  namespace :admin do
    resources :subjects, except: :show
  end

  resources :exams, only: [:index, :create]
  resources :users, only: [:new, :create]
  resources :password_resets, except: [:show, :destroy]
end
