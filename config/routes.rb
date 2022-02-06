Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post '/events', controller: :events, action: :create
      get '/events', controller: :events, action: :index

      get '/search', controller: :search, action: :index
    end
  end
end
