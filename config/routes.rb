HackLa::Application.routes.draw do
  root :to => "home#index"
  
  match '/add_event/:id', to: 'systems#test', as: 'add_event'
  match '/auth/:provider/callback', to: 'sessions#create'
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match '/auth/failure', to:  'sessions#failure'

  resources :users, :only => [:show]
end
