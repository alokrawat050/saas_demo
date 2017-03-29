class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :find_team]
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
  
  protected
  def search_team(team_name)
    @company_master ||= CompanyMaster.find_by(company_name: team_name)
  end
end
