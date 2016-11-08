class PatientsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:id].to_i != session[:user_id]
      not_found
    end    
  end

  def available_appointment
    pat = Patient.find_by_user_id(current_user.id)
    app = Appointment.where(patient_id: pat.id)
    if user_signed_in?
      if app.nil?
        json_resp = 2
      else
        json_resp = 2 - app.size
      end
      respond_to do |format|
        format.json {render json: json_resp}
      end
    else
      not_found
    end 
  end

  def pre_add
    patient = Patient.find_by_user_id(current_user.id)
    if current_user.validated?
      add_appointment
    else
      current_appointments = Appointment.find_by_patient_id(patient.id)
      if current_appointments >= 0 && current_appointments < 2 
        add_appointment
      else
        respond_to do |format|
          format.html { render "public/500", status: 500 }
        end
      end
    end
  end

  def add_appointment
    if user_signed_in?
      patient = Patient.find_by_user_id(current_user.id)
      appointment = Appointment.create(service_id: params[:service_id], accepted: false, appointment_date: params[:appointment_date], patient_id: patient.id)
      if (appointment.persisted?)
        service = Service.find_by_id(params[:service_id])
        clinic = Clinic.find_by_id(service.clinic_id)
        schedule = Schedule.where("day = ? AND hour = ?", params[:appointment_date], params[:appointment_hour])
        schedule.first.update(available: false)
        UserMailer.appointment_email(appointment, current_user, service, clinic).deliver_later
        respond_to do |format|
          format.json { render json: appointment, status: :created }
          #format.html { render }
        end
      else
        format.json { render json: appointment.errors, status: :unprocessable_entity }
      end
    else
      not_found
    end
  end

  def validate_user
    if current_user.validate_token(params[:verification_token])
      json_resp = true
    else
      json_resp = false
    end

    respond_to do |format|
      format.json {render json: json_resp} 
    end
  end

  def available_schedules
    schedules = Schedule.where("service_id = ? AND available = ? AND day = ?", params[:service_id], true, params[:app_date])
    respond_to do |format|
      format.json {render json: schedules}
    end    
  end

  def available_days 
    #hours = Schedule.where("name_id = ?")

  end

  def day_status(day)
    schedules = Schedule.where("service_id = ? AND available = ? AND day = ?", params[:service_id], true, day)
    if schedules.size != 0
      false
    else 
      true
    end
  end

  def month_status
    elem_list = []
    params[:month_days].each do |day|
      if day_status(day)
        elem_list.push(day)
      end
    end
    respond_to do |format|
      format.json {render json: elem_list}
    end
  end

  def update_sensitive_info

  end
  
end