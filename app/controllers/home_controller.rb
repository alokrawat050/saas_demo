class HomeController < ApplicationController
  before_action :authenticate_user!, :is_payment_info_submit
  
  def index
    #find all client details
    @companies = CompanyMaster.all.order(:id)
    
    #find all team mates details
    @invite_users = User.all.order(:id)
  end
end
