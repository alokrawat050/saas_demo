class UsersController < ApplicationController
  before_action :authenticate_user!, :is_payment_info_submit
  def index
    @users = User.all.order(:id)
  end
  
  def new
    @user = User.new
  end
  
  def edit
    
  end
  
  def update
  end
end
