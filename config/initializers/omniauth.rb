Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["835790794723-bitngll5d8d8atu7a9643easifbqfk44.apps.googleusercontent.com"], ENV["Ge64d2-37G1N3HtbOdcqwO86"],
    {
      :name => "google",
      :scope => "email, calendar",
      :prompt => "select_account"
    }
end