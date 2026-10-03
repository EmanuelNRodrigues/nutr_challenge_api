Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :appointment, only: [:create], to: 'public/appointment#create'
      resources :nutritionist, only: [:index] do
        post 'appointment/:appointment_id/accept', to: 'nutritionist#accept_appointment', on: :member
        post 'appointment/:appointment_id/reject', to: 'nutritionist#reject_appointment', on: :member
        get 'appointments', to: 'nutritionist#appointments', on: :member

      end
    end
  end
end
