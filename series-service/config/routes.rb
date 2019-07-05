Rails.application.routes.draw do
  post 'create', to: 'series#create'
  get 'read',	 to: 'series#read'
  put 'update',	 to: 'series#update'
  post 'delete', to: 'series#delete'
  get 'index',	 to: 'series#index'
  post 'read_by_author', to:'series#read_by_author'
  post 'find', to: 'series#find'
end
