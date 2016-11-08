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

  get 'patient/:id' => 'patients#index'
  get 'q/avapp' => 'patients#available_appointment'
  get 'q/month_status' => 'patients#month_status'
end
