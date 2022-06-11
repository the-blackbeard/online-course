Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope(:path => '/api') do
    resources :users, only: [:create]
    resources :courses, only: [:create]
  end
end
