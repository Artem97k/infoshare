Rails.application.routes.draw do
  get 'users/create/', to: 'users#create'
  get 'users/update/', to: 'users#update'
  get 'users/read/', to: 'users#read'
  get 'users/delete/', to: 'users#delete'

    get 'users/index/', to: 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
