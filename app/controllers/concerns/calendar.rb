module Calendar
  require 'google/apis/calendar_v3'
  require 'googleauth'
  require 'googleauth/stores/file_token_store'
  require 'google/api_client/client_secrets.rb'

  def init_calendar
    calendar = Google::Apis::CalendarV3::CalendarService.new
    calendar.authorization = user_credentials_for(calendar)
    # #abort("potato")
    calendar.authorization.refresh!
    #calendar.list_calendar_lists
    calendar
  end

  def user_credentials_for(calendar)
    secrets = Google::APIClient::ClientSecrets.new({"web" => {"access_token" => current_user.auth_token, "refresh_token" => current_user.token_refresh, "client_id" => "631237719552-t3mcqo5lgbp2a0akhmafg8c7smg2te92.apps.googleusercontent.com", "client_secret" => "I2zNUxSFlXF57IriG5Gn01Vs"}})
    #cal = Google::Apis::CalendarV3::CalendarService.new
    secrets.to_authorization
    # calendar.authorization = secrets.to_authorization
    # calendar.authorization.refresh!
    #calendar.list_calendar_lists
  end

  def get_credentials(calendar)
    calendar.authorization
  end

  def get_calendar_list(calendar)
    calendar.list_calendar_lists
  end

  def set_default_calendar
    set = Setting.find_by_user_id(current_user.id)
    if set.nil?
      set = Setting.create(user: current_user, calendar_id: params[:calendar_id])
    else
      set.calendar_id = params[:calendar_id]
      set.save
    end

    respond_to do |format|
      if set.persisted?
        format.json {render json: set, status: :accepted}
      else
        format.json {render json: set.errors, status: :internal_server_error}
      end
    end

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