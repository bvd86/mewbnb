Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Routes for users
  resources :users, only: [:index, :show, :edit, :update]

  # Routes for pokemons
  resources :pokemons do
    # Nested route on pokemons for bookings
    resources :bookings, only: [:new, :create]
  end

  get '/my_listings', to: 'pokemons#my_listings'

  resources :bookings, only: [:index, :show, :edit, :update]
  patch "cancel_booking/:id", to: "bookings#cancel", as: :cancel_booking
  patch "confirm_booking/:id", to: "bookings#confirm", as: :confirm_booking
  patch "rebook_booking/:id", to: "bookings#rebook", as: :rebook_booking
  patch "decline_booking/:id", to: "bookings#decline", as: :decline_booking

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
