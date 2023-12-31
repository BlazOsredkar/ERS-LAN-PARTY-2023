class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :surname, :has_equipment, :user_status_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :surname, :has_equipment, :user_status_id])
  end

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "Nimaš dovoljenja za ogled te strani."
      redirect_to root_path
    end
  end
end
