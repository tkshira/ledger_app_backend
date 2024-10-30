Rails.application.routes.draw do
  resources :users
  resources :transaction_types
  resources :transactions
  get "/transactions-by-month/:year/:month", to: "transactions#transaction_by_month"

  post "/login", to: "auth#login"
  post "/validate_token", to: "auth#validate_token"

  options "*path", to: "application#cors_preflight_check"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
