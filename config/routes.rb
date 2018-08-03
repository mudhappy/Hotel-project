Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :enterprises do
        resources :locals
        resources :rooms
        resources :products
        resources :rooms_states
        resources :rooms_types
      end
      resources :users, only: [:show, :create]
      resources :sessions, only: [:create, :destroy]
    end
  end
end
