Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'main#index'
  resources :employees, except: [ :new, :create ] do
    collection do
      get :search
    end
  end
  resources :time_sheets
  post '/notify_receive', to: 'notify#receive'
  get '/help', to: 'main#help'
  get '/search', to: 'main#search'
end
