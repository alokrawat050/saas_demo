class AccountsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new, :create]
  def new
    @account = Account.new
    @account.build_owner
  end
  
  def create
    @account = Account.new(accounts_params)
    if @account.valid?
      Apartment::Tenant.create(@account.subdomain_name)
      Apartment::Tenant.switch!(@account.subdomain_name)
      if @account.save
        redirect_to new_user_session_url(subdomain: "#{@account.subdomain_name}.gst-alokrawat050")
      else
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end
  
  private
    def accounts_params
      params.require(:account).permit(:subdomain_name, :plan_id, owner_attributes: [:username, :is_admin, :email, :password, :password_confirmation, :password_updated_at])
    end
end
