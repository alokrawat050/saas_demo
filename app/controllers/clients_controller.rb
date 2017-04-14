class ClientsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :find_company_info, only: [:edit, :update, :delete, :destroy]
  def index
    @clients = Client.all.order(:id)
  end
  
  def new
    @client = Client.new
    @client.gstins.build
  end
  
  def create
    @client = Client.new(clients_params)
    if @client.valid?
      if @client.save
        flash[:notice] = "Client Added Successfully."
        #redirect_to new_client_path
        redirect_to root_path
      else
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end
  
  def edit
    #@client.gstin.build
  end
  
  def update
    @client.assign_attributes(:updated_by => current_user.username)
    if @client.update_attributes(clients_params)
      flash[:notice] = "Client Data Updated Successfully."
      redirect_to root_path
    else
      # if update fails, then redisplay the form so user can fix problems
      render('edit')
    end
  end
  
  def delete
  end
  
  def destroy
    attributes = {:del_flag => "true", :updated_by => current_user.username}
    @client.update_attributes(attributes)
    flash[:notice] = "Client '#{@client.client_name}' Scccessfully Deleted."
    #redirect_to client_path
    redirect_to root_path
  end
  
  private
    def clients_params
      params.require(:client).permit(:client_id, :client_name, :owner_name, :owner_email, :client_pan_no, :establish_dt, :gst_username, :gst_password, gstins_attributes: [:id, :gstin_no, :_destroy])
    end
    
    def find_company_info
      @client = Client.find(params[:id])
    end
end
