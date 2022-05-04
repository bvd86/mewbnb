Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Routes for users
  resources :users, only: [:index, :show]

  # Routes for pokemons
  resources :pokemons do
    # Nested route on pokemons for bookings
    resources :bookings, only: [:show, :new, :create]
  end

  resources :bookings, only: [:index, :edit, :update]
  patch "cancel_booking/:id", to: "bookings#cancel", as: :cancel_booking

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
