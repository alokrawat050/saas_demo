class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :load_schema, :authenticate_user!, :set_mailer_host
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation){|u|
      u.permit(:username, :password, :password_confirmation, :invitation_token, :password_updated_at)
    }
  end
  
  private
    def load_schema
      Apartment::Tenant.switch!('public')
      return unless get_subdomain_acc.present?
      
      if current_account
        Apartment::Tenant.switch!(current_account.company_name)
      else
        redirect_to root_url(subdomain: false)
      end
    end
    
    def current_account
      @company_master ||= CompanyMaster.find_by(company_name: get_subdomain_acc)
    end
    
    helper_method :current_account
    
    def set_mailer_host
      subdomain = current_account ? "#{current_account.company_name}." : ""
      ActionMailer::Base.default_url_options[:host] = "#{subdomain}gst-alokrawat050.c9users.io"
    end
      
    def get_subdomain_acc
        return request.subdomain.gsub!(".gst-alokrawat050","")
    end
    
    def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
    end
    
    def after_invite_path_for(resource)
      users_path
    end
end
