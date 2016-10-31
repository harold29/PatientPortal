class UserMailer < ApplicationMailer
  default from: 'support@thesocialus.com'

  def appointment_email(appointment, user, service, clinic)
    @user = user
    @appointment = appointment
    @service = service
    @clinic = clinic
    mail(to: @user.email, subject: 'Cita Creada')
  end
end
