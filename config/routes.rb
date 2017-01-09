Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  #   devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/index'
  root 'home#index'

  resource :patients do 
    member do
      get 'index'
      get 'available_appointment'
      post 'validate_user'
      post 'add_appointment'
      get 'available_schedules'
      post 'update_sensitive_info'
      post 'pre_add'
      get 'month_status'
      post 'patient_emc'
    end
  end

  resource :doctors do
    member do
      get 'index'
      post 'accept_appointment'
      post 'cancel_appointment'
      post 'set_default_calendar'
      post 'set_calendar_in_settings'
      post 'notification_status'
      post 'calendar_sync'
      post 'schedule_settings'
    end
  end

  resource :admin do
    member do
      get 'index'
      post 'update_doctor'
    end
  end

  get 'admin/:id' => 'admin#index'
  post 'admin/update', to: 'admin#update_doctor', as: 'update_patient'
  post 'admin/appointment', to: 'admin#appointment_status', as: 'appointment_status'

  post 'doctor/set_cal', to: 'doctors#set_calendar_in_settings', as: 'set_calendar'
  post 'doctor/notification_status', to: 'doctors#notification_status', as: 'notification_status'
  post 'doctor/calendar_sync', to: 'doctors#calendar_sync', as: 'calendar_sync'
  post 'doctor/schedule_settings', to: 'doctors#schedule_settings', as: 'schedule_settings'

  get 'patient/:id' => 'patients#index'
  get 'q/avapp' => 'patients#available_appointment'
  get 'q/month_status' => 'patients#month_status'

  get 'doctor/:id' => 'doctors#index'
end
