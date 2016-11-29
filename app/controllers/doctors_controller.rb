class DoctorsController < ApplicationController
  def index
    if params[:id].to_i != session[:user_id]
      not_found
    else
      @doctor = Doctor.find_by_user_id(current_user.id)
      if !@doctor.nil?
        @appointments = Appointment.where(service_id: @doctor.service_id)
      end
    end
  end

  # def pending_appointments 
  #   app = Appointment.find_by_service_id(doc.service_id)
  #   if user_signed_in?
  #     if app.nil?
  #       doc = Doctor.find_by_user_id(current_user.id)
  #     end
  #   end
  # end

  def appointment_actions
    if user_signed_in?
      if params[:case] == "accept"
        accept_appointment
      elsif params[:case] == "cancel"
        cancel_appointment
      elsif params[:case] == "mail"
        send_mail_to_patient
      end
    end
  end

  def accept_appointment #ajax
    if user_signed_in? && current_user.id == session[:user_id]
      app = Appointment.find_by_id(params[:appointment_id])
      app.accepted = true
      app.save
      respond_to do |format|
        if app.persisted?
          format.json {render json: app, status: :accepted}
        else
          format.json {render json: app.errors, status: :internal_server_error}
        end
      end
    else
      respond_to do |format|
        format.json {render status: :unauthorized}
      end
    end
  end

  def cancel_appointment #ajax
    if user_signed_in? && current_user.id == session[:user_id]
      app = Appointment.find_by_id(params[:appointment_id])
      app.accepted = false
      app.save
      respond_to do |format|
        if app.persisted?
          format.json {render json: app, status: :accepted}
        else
          format.json {render json: app.errors, status: :internal_server_error}
        end
      end
    else
      respond_to do |format|
        format.json {render status: :unauthorized}
      end
    end
  end

  def send_mail_to_patient

  end

  def get_user_info
    patient = Patient.find_by_id(params[:patient_id])
    user = User.find_by_id(patient.user_id)
  end

  def appointment_history

  end
end
