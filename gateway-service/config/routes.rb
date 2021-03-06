Rails.application.routes.draw do
  post 'signup', to: 'auth#sign_up'
  post 'login',  to: 'auth#log_in'
  get 'logout',  to: 'auth#log_out'

  post 'profile/create', to: 'profile#create'
  get 'profile', 		 to: 'profile#read'
  put 'profile/update',  to: 'profile#update'
  delete 'profile/delete', to: 'profile#delete'

  post 'article/create', to: 'article#create'
  get 'article', 		 to: 'article#read'
  put 'article/update',  to: 'article#update'
  delete 'article/delete', to: 'article#delete'
  post 'article/author', to: 'article#read_by_author'
  post 'article/category', to: 'article#read_by_category'
  post 'article/series', to: 'article#read_by_series'

  post 'series/create', to: 'series#create'
  get 'series', 		 to: 'series#read'
  put 'series/update',  to: 'series#update'
  delete 'series/delete', to: 'series#delete'
  post 'series/author', to: 'series#read_by_author'

  post 'comment/create', to: 'comment#create'
  get 'comment', 		 to: 'comment#read'
  put 'comment/update',  to: 'comment#update'
  delete 'comment/delete', to: 'comment#delete'

  post 'search',     to: 'search#find'

  root to: 'html_renderer#index'
end
