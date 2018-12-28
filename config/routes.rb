Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/', to: 'users#new'
  post '/signup', to: 'users#create'

  get 'tasks/search', to: 'tasks#search'

  resources :tasks
  post 'tasks/start', to: 'tasks#start'
  post 'tasks/end', to: 'tasks#end'
  post 'tasks/sort', to: 'tasks#sort'

end
