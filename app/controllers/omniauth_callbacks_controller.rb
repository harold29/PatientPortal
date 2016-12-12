class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  # TODO: check if it is posible to send a json response. This for update the 
  # user-panel view of admins and doctors.
  # 
  # THIS FILE IS REPEATED PLEASE DELETE!!!!
  
  def google_oauth2

    @user = User.from_omniauth(request.env["omniauth.auth"], session[:user_id])

    if(@user.persisted?)
      flash[:notice] = I18n.t "devise.omniauth_callback.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end
end