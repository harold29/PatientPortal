# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  console.log("potato volador")
  change_status()
  select_calendar()
  gmail_notifications()
  calendar_sync()
  # set_workdays()
  attach_event_appointment_config()
#
# Helper functions for Doctor page
#
#
#cancel_appointment(clicked_button)
change_status = () ->
  $('.confirm-button').click (event) ->
    console.log('click-on-action')
    clicked_button = $(this)
    switch (true)
      when $(this).hasClass('check-button') then if !$("#check-" + $(this).data("appointment")).hasClass('check-accepted')
        console.log("button accept clicked")
        accept_appointment(clicked_button)
      when $(this).hasClass('cancel-button') then if $("#x-" + $(this).data("appointment")).hasClass('x-accepted')
        console.log("button cancel clicked")
        cancel_appointment(clicked_button)
      else

accept_appointment = (button) ->
  app_id = button.data('appointment')
  console.log("accept appointment sequence started")
  $.ajax
    url: "/doctors/accept_appointment",
    type: "POST",
    data: { appointment_id: app_id }
    success: (data, status, jqXHR) ->
      console.log("data " + data)
      console.log("status " + status)
      console.log("jqXHR " + jqXHR)
      if status == "success"
        $("#check-" + app_id).addClass('check-accepted')
        $("#check-" + app_id).removeClass('check-not-accepted')
        $("#check-elem-" + app_id).attr("data-open","potato")
        $("#x-" + app_id).removeClass("x-not-accepted")
        $("#x-" + app_id).addClass('x-accepted')
        #$("#x-" + app_id).attr("data-open", "confirmation-not-accepted-"+app_id)
        $("#x-element-" + app_id).attr("data-open", "confirmation-not-accepted-"+app_id)
      else if status == "unauthorized"
        console.log("change failed")
    error: (data, status, jqXHR) ->

# 
# Cancel Appointment by mosin
# 

cancel_appointment = (button) ->
  app_id = button.data('appointment')
  console.log("negative appointment sequence started")
  $.ajax
    url: "/doctors/cancel_appointment",
    type: "POST",
    data: { appointment_id: app_id }
    success: (data, status, jqXHR) ->
      console.log("data " + data)
      console.log("status " + status)
      console.log("jqXHR " + jqXHR)
      if status == "success"
        $("#x-" + app_id).addClass('x-not-accepted')
        $("#x-" + app_id).removeClass('x-accepted')
        $("#x-element-" + app_id).attr("data-open","potato")
        #$("#x-" + app_id).data("open", "potato")
        $("#check-" + app_id).removeClass("check-accepted")
        $("#check-" + app_id).addClass('check-not-accepted')
        #$("#check-" + app_id).data("open", "confirmation-accepted-"+ app_id)
        $("#check-elem-" + app_id).attr("data-open", "confirmation-accepted-"+app.id)
    error: (data, status, jqXHR) ->

# 
# 
#

select_calendar = () ->
  $(".calendar-selection-list-element").click (event) ->
    cal = $(this).data("cal")
    console.log("calendar-selected")
    console.log(cal)
    $.ajax
      url: "/doctor/set_cal",
      type: "POST",
      data: {calendar_id: cal},
      success: (data, status, jqXHR) ->
        console.log("data " + data)
        console.log("status " + status)
        console.log("jqXHR " + jqXHR)

# 
# 
#

gmail_notifications = () ->
  $("#gmail-notification-label").click (event) ->
    if $("#notifications").is(":checked")
      console.log("no checked!")
      noti = false
      console.log(noti)
    else
      console.log("checked!")
      noti = true
      console.log(noti)

    $.ajax
      url: "notification_status",
      type: "POST",
      data: {notifications: noti}
      success: (data, status, jqXHR) ->
        console.log("data " + data)
        console.log("status " + status)
        console.log("jqXHR " + jqXHR)

calendar_sync = () ->
  $("#gmail-sync-label").click (event) ->
    if $("#sync").is(":checked")
      console.log("no checked!")
      sync = false
      console.log(sync)
    else
      console.log("checked!")
      sync = true
      console.log(sync)

    $.ajax
      url: "calendar_sync",
      type: "POST",
      data: {sync: sync}
      success: (data, status, jqXHR) ->
        console.log("data " + data)
        console.log("status " + status)
        console.log("jqXHR " + jqXHR)

# day_management = (dayname, com) ->
#   $.ajax
#     url: "workday_setting",
#     type: "POST",
#     data: { workday: dayname, command: com }
#     success: (data, status, jqXHR) ->
#       console.log("data " + data)
#       console.log("status " + status)
#       console.log("jqXHR " + jqXHR)

# set_workdays = () ->
#   $(".day_check_box").change (event) ->
#     if $(this).prop('checked')
#       console.log("checked " + $(this).val())
#       # day_management($(this).val(),true)
#     else
#       console.log("not-checked")
#       # day_management($(this).val(),false)

upload_appointment_info = () ->
  days = []
  $(".day_check_box").each (index, elem) ->
    if $(this).prop("checked")
      days.push $(this).val()

  pack = {
    clinic: $('#clinic').val(),
    service: $('#service_id').val(),
    workdays: days,
    initial_hour: $('#date_initial-hour').val(),
    initial_minute: $('#date_initial-minute').val(),
    final_hour: $('#date_final-hour').val(),
    final_minute: $('#date_final-minute').val(),
    duration: $('#appointment_block').val()
  }

send_sch_package = (pack) ->
  $.ajax
    url: "schedule_settings",
    type: "POST",
    data: pack,
    success: (data, status, jqXHR) ->
      $('#appointment_submit_button').prop("disabled", false)
      console.log(data)
      console.log(status)


attach_event_appointment_config = () ->
  $('#clinic').change (event) ->
    $('#service_id').prop("disabled", false)
  $('#appointment_submit_button').click (event) ->
    $(this).prop("disabled", true)
    send_sch_package(upload_appointment_info())