class DoctorsController < ApplicationController

  include Calendar
  include Settings

  # Calendar = Google::Apis::CalendarV3

  def index
    if params[:id].to_i != session[:user_id]
      not_found
    else
      if !current_user.token_refresh.nil?
        @cal = init_calendar
        @calendar = get_calendar_list(@cal)
      end
      @doctor = Doctor.find_by_user_id(current_user.id)
      @setting = Setting.find_by_user_id(current_user.id)
      @w_days = get_w_days(current_user)
      # @calendar = Calendar.new(current_user)
      if !@doctor.nil?
        @appointments = Appointment.where(service_id: @doctor.service_id)
      end
    end
  end

  #
  # Set calendar_id in Settings. Border case not tested. by mosin.
  #

  # def set_calendar_in_settings
  #   setting = Setting.find_by_user_id(current_user.id)
  #   if setting.nil?
  #     setting = Setting.create(user_id: current_user.id, calendar_id: params[:calendar_id])
  #   else
  #     setting.calendar_id = params[:calendar_id]
  #     setting.save
  #   end
  #   respond_to do |format|
  #     if setting.persisted?
  #       format.json {render json: setting, status: :accepted}
  #     else
  #       format.json {render json: setting.error, status: :internal_server_error}
  #     end
  #   end
  # end

  #
  # in Use? by mosin 14/12/16
  #

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
      patient = app.patient
      clinic_name = Service.find_by_id(app.service_id).clinic.name
      schedule = Schedule.find_by_id(app.schedule_id)
      setting = Setting.find_by_user_id(current_user.id)
      app.accepted = true
      if setting.send_notifications
        event = insert_events(patient, clinic_name, schedule, setting, app)
      end
      app.event_id = event.id
      app.save
      respond_to do |format|
        if app.persisted?
          format.json {render json: app, status: :accepted}
        else
          delete_events(setting, event.id)
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
      setting = Setting.find_by_user_id(current_user.id)
      app = Appointment.find_by_id(params[:appointment_id])
      app.accepted = false
      event_id = app.event_id
      app.event_id = nil
      app.save
      respond_to do |format|
        if app.persisted?
          if setting.send_notifications
            delete_events(setting, event_id)
          end
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

  def get_user_info
    patient = Patient.find_by_id(params[:patient_id])
    user = User.find_by_id(patient.user_id)
  end

  def schedule_create(settings, service)
    comp = 0
    w_days = get_w_days(current_user)
    sch = Schedule.where("service_id = ?", service)
    logger.debug "Comp: #{comp}, w_days: #{w_days.nil?}, sch: #{sch.nil?}"
    if !w_days.nil?
      logger.debug "w_days not nil"
      if !sch.nil?
        logger.debug "deleting sch..."
        sch.delete_all
        logger.debug "sch deleted"
      end
      logger.debug "creating work_min... initial_hour: #{settings.initial_work_hour}, final_hour: #{settings.final_work_hour}"
      work_min = ((settings.final_work_hour.to_time - settings.initial_work_hour.to_time) / 60).to_i
      logger.debug "work min created"
      logger.debug "creating block num"
      block_num = work_min/settings.appointment_block
      logger.debug "block num created"
      logger.debug "creating day"
      day = Date.today
      logger.debug "day created"
      logger.debug "creating q"
      q = 90 * block_num
      logger.debug "q created, q: #{q}"
      extension = 90
      logger.debug "Variables assigned: work_min: #{work_min}, block_num: #{block_num}, day: #{day}, extension: #{extension}"
      for k in 1..extension
        if w_days.include? day.strftime("%A")
        hour = settings.initial_work_hour
          logger.debug "Hour: #{hour}"
          for i in 0..block_num
            new_sch = Schedule.create(day: day, hour: hour, available: true, service_id: service, dayname: day.strftime("%A"))
            logger.debug "New Schedule: #{new_sch}"
            if new_sch && new_sch.persisted?
              comp = comp + 1
              logger.debug "COMP PROGRESSION: comp: #{comp}"
            end
            hour = hour + (settings.appointment_block*60)
          end
        else
          extension = extension + 1
        end
        day = day + 1
      end
      if comp == q
        logger.debug "ready"
        true
      else
        logger.debug "comp: #{comp}"
        true
      end
    else
      false
      logger.debug "w_days is nil #{w_days}"
    end
  end
end
