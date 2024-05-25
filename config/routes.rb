Rails.application.routes.draw do
  get 'booking/:id', to: 'booking#show', as: 'booking_show'
  post 'booking/create', to: 'booking#create'
  get 'coaches', to: 'coach#index'
  get 'coach/:id', to: 'coach#show', as: 'coach_show'
  get 'student/new'
  get 'student/logout'
  post 'student/create'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
