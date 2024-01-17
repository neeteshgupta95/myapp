Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :users, only: [:index, :destroy] do
    get :search, on: :collection
  end

  root "users#index"
end
