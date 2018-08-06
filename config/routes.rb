Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :enterprises do
        resources :locals
        resources :rooms do
          match '/:product_id', to: 'rooms#sale_product', via: :post, as: 'sale_product'
        end
        resources :products
        resources :rooms_states
        resources :rooms_types
      end
      resources :users, only: [:show, :create]
      resources :sessions, only: [:create, :destroy]
    end
  end
end
