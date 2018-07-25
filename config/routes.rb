Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :enterprises
      resources :users, only: [:show] 
      resources :sessions, only: [:create, :destroy]
    end
  end
end
