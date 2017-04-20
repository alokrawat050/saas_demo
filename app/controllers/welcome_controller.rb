class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :find_team, :send_customer_mail]
  def index
  end

  def find_team
    if params[:team_name].present? && !params[:team_name].nil? && !params[:team_name].blank?
      Apartment::Tenant.switch!('public')
      if search_team(params[:team_name])
        Apartment::Tenant.switch!(params[:team_name])
        redirect_to new_user_session_url(subdomain: "#{params[:team_name]}.gst-alokrawat050")
      else
        flash[:alert] = "Team Not Found."
        redirect_to root_path
      end
    else
      flash[:alert] = "Please Enter the Team Name."
      redirect_to root_path
    end
  end
  
  def send_customer_mail
    if params[:email].present? && !params[:email].nil? && !params[:email].blank?
      Notifications.send_customer_mail(params[:email], params[:name], params[:subject], params[:message] )
      redirect_to root_path, :notice => "Mail Successfull Send."
    else
      redirect_to root_path, :alert => "Please Enter Mandatory Field."
    end  
  end
  
  protected
  def search_team(team_name)
    @account ||= Account.find_by(subdomain_name: team_name)
  end
end
