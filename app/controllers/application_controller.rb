class ApplicationController < ActionController::Base
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_back_or_to root_path, :alert => exception.message
  end
    before_action :authenticate_user!
    

    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:role, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
