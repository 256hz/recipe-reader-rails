Rails.application.routes.draw do
  get '/', to: redirect('api/v1/')

  namespace :api do
    namespace :v1 do
      get '/', to: 'index#index'

      resources :recipes, only: [:index, :show]
      get 'recipes/:id/ingredients', to: 'recipes#ingredients'
      get 'recipes/:id/equipment', to: 'recipes#equipment'
      get 'recipes/:id/steps', to: 'recipes#steps'

      get '/spoon/:query', to: 'spoon#search'
      get '/spoon/recipe/:id', to: 'spoon#show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end