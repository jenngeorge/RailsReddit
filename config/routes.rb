Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  resources :subs, except: [:destroy]

  resources :posts, except: [:destroy, :index] do
    member do
      resources :comments, only: [:new]
    end
  end
  resources :comments, only: [:create]

  root to: "subs#index"
end
