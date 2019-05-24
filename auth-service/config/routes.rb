Rails.application.routes.draw do
  post 'signup', to: 'users#create'
  get 'signup', to: 'users#create'
  get 'read', to: 'users#read'
  put 'update', to: 'users#update'
  get 'delete', to: 'users#delete'
  post 'auth', to: 'users#auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
