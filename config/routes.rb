Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/" => "home#index", as: :home

  get "/about" => "home#about"

  resources :users, only: [:new, :create, :edit, :update] do
    resources :favourites, only: [:index]
  end

  resources :passwords, only: [:edit, :update, :new] do
    post :link, on: :collection
    get :forgot_password, on: :collection
    patch :update_password, on: :collection
  end
  resources :sessions, only: [:new, :create, :update] do
    delete :destroy, on: :collection
  end

  resources :posts do
    resources :favourites, only: [:create, :destroy]
    resources :comments
    resources :stars, shallow: true, only: [:create, :update, :destroy]
  end


end
