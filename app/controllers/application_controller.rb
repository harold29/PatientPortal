class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    session[:user_id] = resource.id
    case resource.role  
    when "0"
      "/roottoor/#{resource.id}"
    when "1"
      "/admin/#{resource.id}"
    when "2"
      "/patient/#{resource.id}"
    else
      "/patient/#{resource.id}"
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def get_clinics
    
  end

  def get_clinic_services

  end

  def get_service_schedules

  end

  def get_countries

  end

  def get_country_states

  end
end
