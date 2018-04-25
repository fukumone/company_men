Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'main#index'
  resources :employees, only: [ :show ]
  post '/notify_receive', to: 'notify#receive'
  get '/help', to: 'main#help'
end
