class HomeController < ApplicationController
  def index
    if user_signed_in?
      case current_user.role
      when 1
        redirect_to "/patient/" + current_user.id.to_s
      when 2
        redirect_to "/doctor/" + current_user.id.to_s
      when 3
        redirect_to "/patient/" + current_user.id.to_s
      else
        redirect_to "/patient/" + current_user.id.to_s
      end
    end
  end
end
