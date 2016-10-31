# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  appointment_status_change()

appointment_status_change = () ->
  $(".radio-status-form").click (event) ->
      console.log("click option: " + $(this).val())
      $('#appointment-status-form').submit()
