Rails.application.routes.draw do

  root 'pages#home'

  devise_for 	:users, 
  						:path => '', 
  						:path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
  						:controllers => {:omniauth_callbacks => 'omniauth_callbacks',
  														 :registrations => 'registrations',
  														 :passwords => 'passwords'
  														}
  														
 devise_for :admins,
              :path => '', 
  						:path_names => {:sign_in => 'admin123456', :sign_out => 'logout'}
  						
  get 'manage_rooms' => 'admins#rooms'
  get 'manage_reservations' => 'admins#reservations'
  						
  resources :users, only: [:show]
  resources :rooms
  resources :photos
  resources :user_photos
 
  resources :rooms do
    resources :reservations, only: [:create, :destroy]
  end
  
  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'
  get '/your_trips' => 'reservations#your_trips'
  get '/your_reservations' => 'reservations#your_reservations'
  
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
  
  resources :rooms do
    resources :reviews, only: [:create, :destroy]
  end
  
  post '/notify' => 'reservations#notify'
  post '/your_trips' => 'reservations#your_trips'
  
  get 'search' => 'pages#search'
  
end
