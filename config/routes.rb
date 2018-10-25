Rails.application.routes.draw do
  # get 'users' => 'users#index'
  # get 'users/:id' => 'users#show'
  # get 'users/new' => 'users#new'
  # post 'users/create'
  # get 'users/:id/edit' => 'users#edit'
  # put 'users/:id/update' => 'users/update'
  # get 'users/forgotten' => 'users#forgotten'
  # post 'users/recover'
  # delete 'users/:id/destroy'

  get 'users', to: 'users#index', as: 'users'

  get 'users/new', to: 'users#new', as: 'register'
  post 'users', to: 'users#create', as: 'user'

  get 'users/:id/edit', to: 'users#edit' , as: 'edit_profile'
  put 'users/:id', to: 'users#update'

  get 'users/:id', to: 'users#show', as: 'profile'

  delete 'users/:id/destroy', to: 'users#destroy', as: 'delete_profile'

  get 'users/forgotten'
  post 'users/send_forgotten'
  resources :cocktails
  resources :ingredients
  root :to => redirect('/cocktails')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
