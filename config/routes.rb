Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/" => "home#index", as: :home

  get "/about" => "home#about"

  resources :users, only: [:new, :create, :edit, :update] do
    resources :likes, only: [:index]
  end
  resources :passwords, only: [:update, :new, :edit] do
    post :link, on: :collection
    get :forgot_password, on: :collection
    patch :update_password, on: :collection
  end
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :posts do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end


end
