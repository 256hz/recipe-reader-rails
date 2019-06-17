Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recipes, except: [:update, :delete]
      get 'recipes/:id/ingredients', to: 'recipes#ingredients'
      get 'recipes/:id/steps', to: 'recipes#steps'
      resources :steps, except: [:update, :delete]
      resources :ingredients, except: [:update, :delete]
      get '/spoon', to: 'spoon#index'
      get '/spoon/:query', to: 'spoon#search'
      get '/spoon/recipe/:id', to: 'spoon#show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
