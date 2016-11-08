# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  check_available_app()
  $("#validation-form").on("ajax:success", (e, data, status, xhr) ->
    console.log("success:" +  data)
  ).on("ajax:error", (e, xhr, status, error) -> 
    console.log("error")
  )

  on_change_fields()
  calendar_management()

  on_validation_click()

  





# Helper functions  --- Where the magic occurs (yeah sure...) by mosin

on_change_fields = () ->
  $('#clinic').on('change', (e) ->
    clinic_id = $(this).val()
    $('#service_id').removeAttr('disabled')
    console.log(clinic_id)
    $("#service_id option").each( (i,e) ->
      if $(e).val() != ""
        if e.getAttribute('data-clinic') != clinic_id
          $(e).hide()
        else
          $(e).show()
    )
  )

  $('#service_id').on('change', (e) ->
    service_id = $(this).val()
    console.log("service_id retrieved: " + service_id)
    $('#appointment_date').removeAttr('disabled')
    console.log("date enabled")    
  )

  $("#appointment_date").on('input', (e) ->
    console.log("date triggered!")    
    app_date = $(this).val()
    console.log("date retrieved: " + app_date)    
    $('#appointment_hour').removeAttr('disabled')
    console.log("app_date: " + app_date)
    schedule_ajax app_date,service_id 
  )


check_available_app = () ->
  $.ajax
    url: "/q/avapp",
    success: (data, status, jqXHR) ->
      console.log("llanto: " + data)
      $("#available-apps").html(data)
      data
    error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)
        console.log(error: errorThrown)

calendar_management = () ->
  $("#appointment_date").click (event) ->
    console.log("click")
    $("#validation-container").hide()
    $("#hours-container").hide()
    $("#calendar-container").show()
    $("#calendar").fullCalendar
      dayClick: (date, jsEvent, view) -> 
        $("#appointment_date").val(date.format("DD-MM-YYYY"))
        $("#appointment_date").attr("data-date",date.format("YYYY-MM-DD"))
        console.log("POTEITO VOLADOR")
        serviceid = $("#service_id").val() 
        console.log("POTEITO VOLADOR2")
        schedule_ajax date.format("YYYY-MM-DD"), serviceid #ajax request sending for schedule hours
      monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
      monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
      dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
      dayNamesShort: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
      aspectRatio: 1,
      height: "parent",
      contentHeight: "auto",
      header: {
        left: '',
        center: 'prev, title, next',
        right: ''
      }
    get_date_cal()
    on_calendar_change_event()

      
hours_management = (schedule_hours) ->
  $('#appointment_hour').click (event) ->
    $('#validation-container').hide()
    $('#calendar-container').hide()
    $('#hours-container').show()
    radio_button = "<div class='large-6 medium-6 small-6 column'>"
    console.log(schedule_hours)
    half = Math.ceil(schedule_hours.length / 2)
    for hour, i in schedule_hours
      id = hour.id
      filtered_hour = ((hour.hour).toString()).match(/([01]\d|2[0-3]):?([0-5]\d)/g)[1]
      if i == half
        radio_button = radio_button + "</div><div class='large-6 medium-6 small-6 column'>"
      else if i == schedule_hours.length
        radio_button = radio_button + "</div>"
      else
         # Returns a string with the hour in second position
        radio_button = radio_button + "<div class='row'><input type='radio' id='radio-" + i.toString() + "' class='hours-radio' name='schedule_hours' value='" + id.toString() + "' data-text='" + (hour.hour).toString() + "'><label class='radio-label' for='radio-"+i.toString()+"'>" + filtered_hour + "</label></div>"
    $('#hours').html(radio_button)
    $('.hours-radio').on('change', (e) ->
      $('#appointment_hour').val($("label[for=" + $(this).attr("id") + "]").text())
      #$('')
    )

schedule_ajax = (appdate, serviceid) ->
    #serviceid = $()
    console.log("schedule request")
    $('#appointment_hour').removeAttr('disabled')
    $.ajax
      url: "/patients/available_schedules/"
      data: {service_id: serviceid, app_date: appdate}
      success: (data, status, jqXHR) ->
        hours_management data
        console.log("success...")
        console.log("hours: " + data)

#
# Effects function for fade out
#

on_validation_click = () ->
  $("#access-button").click (event) ->
    $("#available-box").fadeOut()
    $("#vc-deco").fadeOut()


#
# Set up days
#

# $(".fc-day-number").addClass () ->
#   $(".")

get_date_cal = () ->
  console.log("get_date_cal function enabled")
  $(".fc-day-number").click (event) ->
    console.log("pre-click")
    $("#appointment_date").val(moment($(this).data("date")).format("DD-MM-YYYY"))
    console.log("post-click")
    $("#appointment_date").attr("data-date", moment($(this).data("date")).format("YYYY-MM-DD"))
    serviceid = $("#service_id").val()
    schedule_ajax moment($(this).data("date")).format("YYYY-MM-DD"), serviceid
  

on_calendar_change_event = () ->
  console.log("calendar change function attached")
  $(".fc-button").click (event) ->
    console.log("calendar change button clicked")
    get_date_cal()
    #get_date_cal