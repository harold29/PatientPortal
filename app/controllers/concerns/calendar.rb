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

  def create_new_calendar
    
  end

  def get_events
  
  end

  def insert_events
    
  end

  def update_events

  end

  def delete_events

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