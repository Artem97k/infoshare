Rails.application.routes.draw do
  post 'create', to: 'articles#create'
  get 'read',	 to: 'articles#read'
  put 'update',	 to: 'articles#update'
  post 'delete', to: 'articles#delete'
  post 'delete_by_series', to: 'articles#delete_by_series'
  get 'index',	 to: 'articles#index'
  post 'read_by_author', to: 'articles#read_by_author'
  post 'read_by_category', to: 'articles#read_by_category'
  post 'read_by_series', to: 'articles#read_by_series'
  post 'find', to: 'articles#find'
end
