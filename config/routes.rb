Rails.application.routes.draw do
  resources :tasks
  devise_for :users

  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  resources :projects do
    resources :notes, except: :show
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
