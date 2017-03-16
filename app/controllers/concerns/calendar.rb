module Calendar
  require 'google/apis/calendar_v3'
  require 'googleauth'
  require 'googleauth/stores/file_token_store'
  require 'google/api_client/client_secrets.rb'

  def init_calendar
    calendar = Google::Apis::CalendarV3::CalendarService.new
    calendar.authorization = user_credentials_for(calendar)
    calendar.authorization.refresh!
    calendar
  end

  def user_credentials_for(calendar)
    secrets = Google::APIClient::ClientSecrets.new({"web" => {"access_token" => current_user.auth_token, "refresh_token" => current_user.token_refresh, "client_id" => "631237719552-t3mcqo5lgbp2a0akhmafg8c7smg2te92.apps.googleusercontent.com", "client_secret" => "I2zNUxSFlXF57IriG5Gn01Vs"}})
    secrets.to_authorization
  end

  def get_credentials(calendar)
    calendar.authorization
  end

  def get_calendar_list(calendar)
    calendar.list_calendar_lists
  end

  #
  # Set calendar_id in Settings. Border case not tested. by mosin.
  #

  def set_calendar_in_settings
    setting = Setting.find_by_user_id(current_user.id)
    if setting.nil?
      setting = Setting.create(user_id: current_user.id, calendar_id: params[:calendar_id])
    else
      setting.calendar_id = params[:calendar_id]
      setting.save
    end
    respond_to do |format|
      if setting.persisted?
        format.json {render json: setting, status: :accepted}
      else
        format.json {render json: setting.error, status: :internal_server_error}
      end
    end
  end

  def notification_status
    setting = Setting.find_by_user_id(current_user.id)
    logger.debug params[:notifications]
    if setting.nil?
      setting = Setting.create(user_id: current_user.id, send_notifications: params[:notifications])
    else
      setting.send_notifications = params[:notifications]
      setting.save
    end

    respond_to do |format|
      if setting.persisted?
        format.json {render json: setting, status: :accepted}
      else
        format.json {render json: setting.errors, status: :internal_server_error}
      end
    end
  end

  def calendar_sync
    setting = Setting.find_by_user_id(current_user.id)
    if setting.nil?
      setting = Setting.create(user_id: current_user.id, cal_sync: params[:sync])
    else
      setting.cal_sync = params[:sync]
      setting.save
    end

    respond_to do |format|
      if setting.persisted?
        format.json {render json: setting, status: :accepted}
      else
        format.json {render json: setting.errors, status: :internal_server_error}
      end
    end
  end

  def insert_events(patient, clinic_name, schedule, setting, appointment)
    hour = schedule.hour.in_time_zone('America/Mexico_City')
    start_hour = hour.strftime("%H:%M:%S")
    day = schedule.day.strftime
    time_zone = hour.strftime("%z")
    start_date_time = day + "T" + start_hour + time_zone
    ab = setting.appointment_block*60
    user = patient.user
    end_hour = (hour + ab).strftime("%H:%M:%S")
    end_date_time = day + "T" + end_hour + time_zone

    summary = 'Cita médica con: ' + user.name + " " + user.last_name

    event = Google::Apis::CalendarV3::Event.new({
      summary: summary,
      # location: ,
      description: 'Cita médica con: ' + user.name + " " + user.last_name + ' en: ' + clinic_name,
      start: {
        date_time: start_date_time,
        time_zone: 'America/Mexico_City',
      },
      end: {
        date_time: end_date_time,
        time_zone: 'America/Mexico_City',
      },
      attendees: [
        { email: user.email },
        { email: current_user.email },
      ]
    })

    logger.debug event.inspect

    calendar = init_calendar
    logger.debug calendar.inspect
    result = calendar.insert_event(setting.calendar_id, event)
  end

  # Description of method
  #
  # @param [Type] settings describe settings
  # @param [Type] event_id describe event_id
  # @return [Type] description of returned object
  def delete_events(settings, event_id)
    calendar = init_calendar
    result = calendar.delete_event(settings.calendar_id, event_id)
    # result = delete_event()
  end

  def update_events

  end

  def create_calendar

  end

  private

  def convert_to_gcal_event

  end

  def get_event_location

  end

  def init_client

  end

  def client

  end

  def calendar

  end
end
