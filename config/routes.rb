
Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end  
  resources :styles

  root 'breweries#index'
  #get 'kaikki_bisset', to: 'beers#index'
  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to: 'ratings#new'

  #post 'ratings', to: 'ratings#create'

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'places', to: 'places#index'
  post 'places', to: 'places#search'
  post 'places', to: 'places#search'
  post 'set_blocked', to: 'users#set_blocked'
  delete 'signout', to: 'sessions#destroy'


resources :ratings, only: [:index, :new, :create, :destroy]
resources :places, only: [:index, :show]
resource :session, only: [:new, :create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
