# Load the Rails application.
require_relative 'application'

#ActionMailer gmail's smtp configuration
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address               =>   'smtp.gmail.com',
  :domain                =>   'mail.google.com',
  :port                  =>   587,
  :user_name             =>   'harold@thesocialus.com',
  :password              =>   '20220565hjpc',
  :authentication        =>   :plain,
  :enable_starttls_auto  =>   true
}
ActionMailer::Base.raise_delivery_errors = true
#ActionMailer::Base.logger = true

# Initialize the Rails application.
Rails.application.initialize!
