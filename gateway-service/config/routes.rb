Rails.application.routes.draw do
  post 'signup', to: 'auth#sign_up'
  post 'login',  to: 'auth#log_in'
  get 'logout',  to: 'auth#log_out'

  post 'profile/create', to: 'profile#create'
  get 'profile', 		 to: 'profile#read'
  put 'profile/update',  to: 'profile#update'
  post 'profile/delete', to: 'profile#delete'
end
