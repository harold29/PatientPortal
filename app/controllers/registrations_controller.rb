class RegistrationsController < Devise::RegistrationsController
    #TODO: Check if fails the pacient creation in border cases
    # This method creates a person for devise auth, and creates
    # the associate pacient that would save all the person
    # infomation
    # TODO: Check if the method are already assigning the resource
    # id to pacient's person_id



  def create
    logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    build_resource(sign_up_params)

    # Default values for user model -- created set_default_values on User model
    # resource.role = 2
    # resource.disabled = false
    # resource.validated = false

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
 
        # Associated patient
        resource_patient = Patient.new(:user_id => resource.id)
        resource_patient.save
        if resource_patient.persisted?
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          resource.destroy
        end

      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords_resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private
  
  def sign_up_params
    params.require(:user).permit(:name, :last_name, :email, :birthday, :password, :password_confirmation)
  end

  protected

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def account_update_params
    params.require(:user).permite(:name, :last_name, :email, :birthday, :age, :password, :password_confirmation, :current_password, )
  end

  def new
    super
  end

  def update
    super
  end
end