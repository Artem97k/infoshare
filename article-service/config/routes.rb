Rails.application.routes.draw do
  post 'create', to: 'articles#create'
  get 'read',	 to: 'articles#read'
  put 'update',	 to: 'articles#update'
  post 'delete', to: 'articles#delete'
  get 'index',	 to: 'articles#index'
  post 'read_by_author', to: 'articles#read_by_author'
  post 'find', to: 'articles#find'
end
