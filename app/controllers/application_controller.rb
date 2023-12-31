class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def set_project
    @project = Project.find(params[:project_id])
  end

  def project_owner?
    unless @project.owner == current_user
      redirect_to root_path, alert: "You don't have access to that project."
    end
  end

  def configure_permitted_parameters
    %i[sign_up account_update].each do |action|
      devise_parameter_sanitizer.permit(action, keys: [:first_name, :last_name])
    end
  end
end
