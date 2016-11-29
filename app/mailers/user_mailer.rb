class UserMailer < ApplicationMailer
  # 
  # TODO: create mailer for doctor custom message to patient
  # 

  default from: 'support@thesocialus.com'

  def appointment_email(appointment, user, service, clinic)
    @user = user
    @appointment = appointment
    @service = service
    @clinic = clinic
    mail(to: @user.email, subject: 'Cita Creada')
  end

  #def doctor_email(m)
end
