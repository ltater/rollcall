Rails.application.routes.draw do
  root "players#index"

  resources :players do
    member do
      post :send_notification
    end
  end

  resources :teams do
    member do
      post :add_player
      post :remove_player
    end
  end

  resources :games do
    member do
      post :initialize_rsvps
    end
  end

  resources :rsvps, only: [:update]

  # get "players/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
