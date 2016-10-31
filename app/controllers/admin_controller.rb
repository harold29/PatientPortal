class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:id].to_i != session[:user_id]
      not_found
    else
      @doc = Doctor.find_by_user_id(current_user.id)
      @patients = Patient.find_by_doctor_id(@doc.id)
      @appointments = Appointment.where(service_id: @doc.service_id)
      @schedules = Schedule.where(service_id: @doc.service_id)
    end
  end

  def appointment_status
    app = Appointment.find_by_id(params[:appointment_id])

    json_resp = app.update(accepted: params[:accepted])

    respond_to do |format|
      format.json {render json: json_resp}
    end
  end

  def update_doctor

  end
end
