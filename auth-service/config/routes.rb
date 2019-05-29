Rails.application.routes.draw do
  post 'create', to: 'users#create'
  get 'read', to: 'users#read'
  put 'update', to: 'users#update'
  post 'delete', to: 'users#delete'
  post 'auth', to: 'users#auth'
  get 'index', to: 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
