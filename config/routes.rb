Rails.application.routes.draw do
  devise_for :users
  resources :reservations
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: [:create, :show, :update]
      resources :items
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
