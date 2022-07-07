Rails.application.routes.draw do
  resources :referral_rates
  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'
  get '/profile', to: 'profiles#index'
  get '/profile/transactions', to: 'profiles#transactions'
  namespace :admin do
    resources :users
    resources :plans
    resources :user_transactions
  end
end