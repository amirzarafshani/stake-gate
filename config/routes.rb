Rails.application.routes.draw do
  resources :user_transactions
  resources :users
  post '/auth/login', to: 'authentication#login'
  namespace :admin do
    resources :plans
  end
end