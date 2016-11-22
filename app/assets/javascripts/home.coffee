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
      #$('input[name="pass_confirmation"]').displayPasswordStrength(optionalConfig)

