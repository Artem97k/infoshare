Rails.application.routes.draw do
  post 'signup', to: 'auth#sign_up'
  post 'login',  to: 'auth#log_in'
  get 'logout',  to: 'auth#log_out'

  post 'profile/create', to: 'profile#create'
  get 'profile', 		 to: 'profile#read'
  put 'profile/update',  to: 'profile#update'
  post 'profile/delete', to: 'profile#delete'

  post 'article/create', to: 'article#create'
  get 'article', 		 to: 'article#read'
  put 'article/update',  to: 'article#update'
  post 'article/delete', to: 'article#delete'

  post 'series/create', to: 'series#create'
  get 'series', 		 to: 'series#read'
  put 'series/update',  to: 'series#update'
  post 'series/delete', to: 'series#delete'

  post 'comment/create', to: 'comment#create'
  get 'comment', 		 to: 'comment#read'
  put 'comment/update',  to: 'comment#update'
  post 'comment/delete', to: 'comment#delete'

  root to: 'html_renderer#index'
end
