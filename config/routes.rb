Rails.application.routes.draw do
  get 'welcome', to: 'login#show', as: 'welcome'

  match 'sessions/create', to: 'sessions#create', via: :post, as: 'login'
  match 'sessions/destroy', to: 'sessions#destroy', via: [:delete, :get], as: 'logout'

  # users shouldn't be accessible
  # get 'users', to: 'users#index', as: 'users'

  get 'users/new', to: 'users#new', as: 'register'
  post 'users', to: 'users#create', as: 'user'

  get 'users/:id/clear', to: 'users#clear_notifs' , as: 'clear_notifs'
  get 'users/:id/edit', to: 'users#edit' , as: 'edit_profile'
  put 'users/:id', to: 'users#update', as: 'update_profile'

  get 'users/forgotten'
  post 'users/send_forgotten'

  get 'users/:id', to: 'users#show', as: 'profile'

  delete 'users/:id/destroy', to: 'users#destroy', as: 'delete_profile'

  post 'cocktails/:id/share', to: 'cocktails#share', as: 'share_cocktail'

  resources :cocktails

  post 'ingredients/:id/share', to: 'ingredients#share', as: 'share_ingredient'
  post 'ingredients/:id/have', to: 'ingredients#have', as: 'store'

  resources :ingredients

  root :to => redirect('/welcome')
end
