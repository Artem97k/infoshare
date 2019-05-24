Rails.application.routes.draw do
  post 'create', to: 'profiles#create'
  get 'read', to: 'profiles#read'
  put 'update', to: 'profiles#update'
  delete 'delete', to: 'profiles#delete'
end
