# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  console.log("potato volador")
  change_status()



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
  $(".calendar-selection-item").click (event) ->
    console.log("calendar-selected")
    $.ajax
      url: "/doctors/set_default_calendar",
      type: "POST",
      data: {calendar_id: }

change_calendar = (button) ->
   