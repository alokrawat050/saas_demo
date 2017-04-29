class UsersController < ApplicationController
  before_action :authenticate_user!, :is_payment_info_submit
  before_action :find_user_info, only: [:edit, :update, :delete, :destroy]
  
  def index
    @users = User.all.order(:id)
  end
  
  def new
    @user = User.new
  end
  
  def edit
  end
  
  def update
    @invite_users = User.all.order(:id)
    @clients = Client.all.order(:id)
    @invite_user.assign_attributes(:updated_by => current_user.username)
    if @invite_user.update_attributes(user_params)
      flash[:notice] = "Data Updated Successfully."
    else
      # if update fails, then redisplay the form so user can fix problems
      #render('edit')
    end
  end
  
  def delete
  end
  
  def destroy
    @invite_user.destroy
    redirect_to root_path, :notice => "User Successfully Deleted."
  end
  
  private
    def user_params
      params.require(:user).permit(:is_admin, :is_user_active)
    end
    
    def find_user_info
      @invite_user = User.find(params[:id])
    end
end
