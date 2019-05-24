Rails.application.routes.draw do
  get 'signup', to: 'auth#sign_up'
  get 'login', to: 'auth#log_in'
  get 'logout', to: 'auth#log_out'

  post 'profile/create/', to: 'profile#create'
  get 'profile/:login', to: 'profile#read'
  put 'profile/:login/update/', to: 'profile#update'
  delete 'profile/:login/delete/', to: 'profile#delete'
end
