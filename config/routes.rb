Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  resources :subs, except: [:destroy]

  resources :posts, except: [:destroy, :index]

  root to: "subs#index"
end
