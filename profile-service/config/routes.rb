Rails.application.routes.draw do
  post 'create', to: 'profiles#create'
  get 'read',	 to: 'profiles#read'
  put 'update',	 to: 'profiles#update'
  post 'delete', to: 'profiles#delete'
  get 'index',	 to: 'profiles#index'
  get 'token',	 to: 'profiles#view_token'
end
