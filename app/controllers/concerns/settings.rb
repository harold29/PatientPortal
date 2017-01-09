module Settings

  def schedule_settings
    setting =  Setting.find_by_user_id(current_user.id)
    if setting.nil?
      setting = Setting.new
    end
    set_dbday_from_number(setting, params[:workdays], true)
    init_time = Time.parse(params[:initial_hour] + ":" + params[:initial_minute])
    final_time = Time.parse(params[:final_hour] + ":" + params[:final_minute])
    setting.initial_work_hour = init_time
    setting.final_work_hour = final_time
    setting.appointment_block = params[:duration]
    if setting.save
      respond_to do |format|
        if setting.persisted?
          if schedule_create(setting,params[:service])
            format.json {render json: setting, status: :ok}
          end
        else
          format.json {render json: setting.errors, status: :internal_server_error}
        end
      end
    end
  end

  def set_dbday_from_number(setting, days, command)
    logger.debug days
    logger.debug command
    days.each do |num|
      logger.debug num
      case num
      when '0'
          logger.debug "mon"
          setting.workday_mon = command
      when '1'
          logger.debug "tue"
          setting.workday_tue = command
      when '2'
          logger.debug "wed"
          setting.workday_wed = command
      when '3'
          logger.debug "thu"
          setting.workday_thu = command
      when '4'
          logger.debug "fri"
          setting.workday_fri = command
      when '5'
          logger.debug "sat"
          setting.workday_sat = command
      when '6'
          logger.debug "sun"
          setting.workday_sun = command
      else
        "Not a day"
      end
    end

    if !days.include? '0'
      setting.workday_mon = false
    end

    if !days.include? '1'
      setting.workday_tue = false
    end

    if !days.include? '2'
      setting.workday_wed = false
    end

    if !days.include? '3'
      setting.workday_thu = false
    end

    if !days.include? '4'
      setting.workday_fri = false
    end

    if !days.include? '5'
      setting.workday_sat = false
    end

    if !days.include? '6'
      setting.workday_sun = false
    end
  end

  def get_w_days(user)
    w_days = []
    if current_user.role == 2 && user_signed_in?  
      setting = Setting.find_by_user_id(user.id)
      if !setting.nil?
        if setting.workday_mon
          logger.debug "pushed 0"
          w_days.push("Monday")
        end
        logger.debug "w_days status1: #{w_days.join(",")}"
        if setting.workday_tue
          logger.debug "pushed 1"
          w_days.push("Tuesday")
        end 
        logger.debug "w_days status2: #{w_days.join(",")}"
        if setting.workday_wed
          logger.debug "pushed 2"
          w_days.push("Wednesday")
        end 
        logger.debug "w_days status3: #{w_days.join(",")}"
        if setting.workday_thu
          logger.debug "pushed 3"
          w_days.push("Thursday")
        end 
        logger.debug "w_days status4: #{w_days.join(",")}"
        if setting.workday_fri
          logger.debug "pushed 4"
          w_days.push("Friday")
        end 
        logger.debug "w_days status5: #{w_days.join(",")}"
        if setting.workday_sat
          logger.debug "pushed 5"
          w_days.push("Saturday")
        end 
        logger.debug "w_days status5: #{w_days.join(",")}"
        if setting.workday_sun
          logger.debug "pushed 6"
          w_days.push("Sunday")
        end
        w_days
      else
        logger.debug "setting is nil"
        nil
      end      
    end
  end
end