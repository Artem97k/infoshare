Rails.application.routes.draw do
  get 'users/create/', to: 'users#create'
  get 'users/showall/', to: 'users#showall'
  get 'users/showmatch/', to: 'users#showmatch'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
