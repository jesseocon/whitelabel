Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  devise_for :users, module: "admin", path: 'admin'
  # config/routes.rb
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/', to: 'pages#index', constraints: Subdomain, via: :all
  match '/graphql', to: "graphql#execute", constraints: Subdomain, via: :all
  root to: 'homepage#index'
  resources :homepage, only: [:index]
  resources :pages, only: [:index]

  namespace :admin do
    resources :themes do
      resources :templates
      resources :sections
    end
    resource :account, controller: 'accounts'
  end
end
