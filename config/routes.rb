Rails.application.routes.draw do
  get '/', to: redirect('api/v1/')

  namespace :api do
    namespace :v1 do
      get '/', to: 'index#index'

      resources :recipes, except: [:create, :update, :delete]
      get 'recipes/:id/ingredients', to: 'recipes#ingredients'
      get 'recipes/:id/equipment', to: 'recipes#equipment'
      get 'recipes/:id/steps', to: 'recipes#steps'

      resources :steps, except: [:create, :update, :delete]

      resources :ingredients, except: [:create, :update, :delete]

      get '/spoon', to: 'spoon#index'
      get '/spoon/:query', to: 'spoon#recipe_search'
      get '/spoon/recipe/:id', to: 'spoon#show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end