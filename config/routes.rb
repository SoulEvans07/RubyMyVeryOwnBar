Rails.application.routes.draw do
  resources :users
  resources :cocktails
  resources :ingredients
  root :to => redirect('/cocktails')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
