Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "631237719552-t3mcqo5lgbp2a0akhmafg8c7smg2te92.apps.googleusercontent.com", "I2zNUxSFlXF57IriG5Gn01Vs",
    {
      :name => 'google',
      :scope => 'userinfo.email userinfo.profile https://www.googleapis.com/auth/calendar',
      :prompt => 'select_account'
    }
end