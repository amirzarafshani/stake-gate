Rails.application.routes.draw do
  resources :referral_rates
  resources :plans, only: [:index]
  resources :assets, only: [:index, :create]
  resources :releases, only: [:index, :create]
  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'
  get '/profile', to: 'profiles#index'
  get '/referrals', to: 'profiles#referrals'
  get '/sliders', to: 'sliders#index'
  namespace :admin do
    resources :sliders
    resources :users
    resources :plans
    resources :referral_rates
    resources :assets
    resources :releases
    get 'dashboard', to: "dashboard#index"
  end
end