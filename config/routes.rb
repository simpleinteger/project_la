HackLa::Application.routes.draw do
  root :to => "home#index"

  match '/auth/:provider/callback' => 'sessions#create'

  resources :users, :only => [:index, :show, :edit, :update ]
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
