class PatientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @patient = Patient.find_by_user_id(current_user.id)
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
      schedule = Schedule.where("day = ? AND hour = ?", params[:appointment_date], params[:appointment_hour])[0]
      appointment = Appointment.create(service_id: params[:service_id], accepted: false, appointment_date: params[:appointment_date], patient_id: patient.id, schedule_id: schedule.id)
      if (appointment.persisted?)
        service = Service.find_by_id(params[:service_id])
        clinic = Clinic.find_by_id(service.clinic_id)
        schedule.update(available: false)
        UserMailer.appointment_email(appointment, current_user, service, clinic).deliver_later
        respond_to do |format|
          format.json { render json: appointment, status: :created }
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
      format.json {render json: schedules.reverse}
    end
  end

  def available_days
    #hours = Schedule.where("name_id = ?")

  end

  def day_status(day, serviceid)
    schedules = Schedule.where("service_id = ? AND available = ? AND day = ?", serviceid, true, day)
    logger.debug schedules.size
    if schedules.size != 0
      true
    else
      false
    end
  end

  def month_status
    elem_list = []
    params[:month_days].each do |day|
      logger.debug day
      if day_status(day, params[:service_id])
        elem_list.push(true)
      else
        elem_list.push(false)
      end
    end
    #logger.debug elem_list.zip(params[:month_days]).join(",")
    respond_to do |format|
      format.json {render json: elem_list.zip(params[:month_days])}
    end
  end

  def patient_emc
    # TODO: When patient updates the emc's, this models duplicates, see why
    if user_signed_in?
      patient = Patient.find_by_user_id(current_user.id)
      logger.debug patient.inspect
      aux = Relative.new(relative_params)
      logger.debug relative_params.inspect
      logger.debug aux.inspect
      rel = Relative.find_by_id(aux.id)

      if !rel.nil?
        logger.debug "condition 1 accomplished"
        rel.update_attributes(name: aux.name, kinship: aux.kinship, phone1: aux.phone1, phone2: aux.phone2)
      else
        logger.debug "condition 2 accomplished"
        rel = Relative.create(name: aux.name, kinship: aux.kinship, phone1: aux.phone1, phone2: aux.phone2)
        rel.patient = patient
      end
      rel.save
      respond_to do |format|
        format.json {render json: rel.persisted? ? rel : rel.errors, status: rel.persisted? ? :ok : :unprocessable_entity }
      end
      # respond_to do |format|
      #   # if rel.persisted?
      #   #   format.json {render json: rel, status: :ok}
      #   # else
      #   #   format.json { render json: rel.errors, status: :unprocessable_entity }
      #   # end
      # end
    else
      not_found
    end
  end

  private
    def relative_params
      params.require(:relative).permit(:id, :name, :kinship, :phone1, :phone2)
    end

end
