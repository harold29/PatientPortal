# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $.validate
    modules : 'date, security'
    form: '#form-login, #registration-form',
    borderColorOnError: '#FE3102', # red1-msc
    onModulesLoaded: () ->
      optionalConfig = {
        fontSize: '0pt',
        padding: '4px',
        bad : 'Muy Debil',
        weak : 'Debil',
        good : 'Buena',
        strong : 'Fuerte'
      }
  $ ->
    $("#user_birthday").fdatepicker
      # initialDate: '01-01-1950',
      format: 'dd/mm/yyyy',
      disableDblClickSelection: true,
      leftArrow: '<<',
      rightArrow: '>>',
      closeIcon: 'x',
      language: 'es'
      closeButton: true

      #$('input[name="pass_confirmation"]').displayPasswordStrength(optionalConfig)
