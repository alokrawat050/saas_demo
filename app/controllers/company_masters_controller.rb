class CompanyMastersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new, :create]
  def new
    @company_master = CompanyMaster.new
    @company_master.build_owner
  end
  
  def create
    @company_master = CompanyMaster.new(company_master_params)
    if @company_master.valid?
      Apartment::Tenant.create(@company_master.company_name)
      Apartment::Tenant.switch!(@company_master.company_name)
      if @company_master.save
        redirect_to new_user_session_url(subdomain: "#{@company_master.company_name}.gst-alokrawat050")
      else
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end
  
  private
    def company_master_params
      params.require(:company_master).permit(:company_name, owner_attributes: [:username, :is_admin, :email, :password, :password_confirmation, :password_updated_at])
    end
end
