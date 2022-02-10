Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :events
      resources :organizations do
        resources :events, only: [:index], controller: :org_events
      end
      # resources :org_users
      # resources :sessions, only: :create
      get '/search', controller: :search, action: :index
    end
  end
end
