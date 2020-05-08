Rails.application.routes.draw do
  post '/event', to: 'events#attend_event'
  delete '/event', to: 'events#cancel_attendance'
  devise_for :users
  resources :users, only: [:show]
  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "events#index"
end
