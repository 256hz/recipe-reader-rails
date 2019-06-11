Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recipes
      resources :steps
      resources :ingredients
      get '/spoon', to: 'spoon#index'
      get '/spoon/:query', to: 'spoon#search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
