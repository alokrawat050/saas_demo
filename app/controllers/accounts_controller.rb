class AccountsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new, :create]
  def new
    @account = Account.new
    @account.build_owner
    
    #store plan id in session
    session[:plan_id] = params[:plan_id]
  end
  
  def create
    @account = Account.new(accounts_params)
    @account.assign_attributes(:plan_id => session[:plan_id])
    if @account.valid?
      Apartment::Tenant.create(@account.subdomain_name)
      Apartment::Tenant.switch!(@account.subdomain_name)
      if @account.save
        session[:plan_id] = nil
        redirect_to new_user_session_url(subdomain: "#{@account.subdomain_name}.demo-alokrawat050")
      else
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end
  
  private
    def accounts_params
      params.require(:account).permit(:subdomain_name, owner_attributes: [:username, :is_admin, :email, :password, :password_confirmation, :password_updated_at])
    end
end
