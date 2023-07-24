require 'sidekiq/web'
Rails.application.routes.draw do
  root "dashboard#index"
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # get '/sidekiq', to: 'some#some_action'
  
    mount Sidekiq::Web => '/sidekiq'
    get 'tasks/search_projects', to: 'tasks#search_projects', defaults: { format: 'json' }
    resources :projects
  resources :tasks do
    collection do
      get 'search'
    end
  end

end
