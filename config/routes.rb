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
    resources :questions, except: :show
  end

  resources :exams, except: :destroy
  resources :users, only: %i(new create)
  resources :password_resets, except: %i(show destroy)
end
