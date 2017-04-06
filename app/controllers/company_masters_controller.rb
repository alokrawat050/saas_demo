class CompanyMastersController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :find_company_info, only: [:edit, :update, :delete, :destroy]
  def index
    @companies = CompanyMaster.all
  end
  
  def new
    @company_master = CompanyMaster.new
    @company_master.gstins.build
  end
  
  def create
    @company_master = CompanyMaster.new(company_masters_params)
    if @company_master.valid?
      if @company_master.save
        flash[:notice] = "Client Added Successfully."
        redirect_to new_company_master_path
      else
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end
  
  def edit
    #@company_master.gstin.build
  end
  
  def update
    @company_master.assign_attributes(:updated_by => current_user.username)
    if @company_master.update_attributes(company_masters_params)
      flash[:notice] = "Client Data Updated Successfully."
      redirect_to company_masters_path   
    else
      # if update fails, then redisplay the form so user can fix problems
      render('edit')
    end
  end
  
  def delete
  end
  
  def destroy
    attributes = {:del_flag => "true", :updated_by => current_user.username}
    @company_master.update_attributes(attributes)
    flash[:notice] = "Client '#{@company_master.company_name}' Scccessfully Deleted."
    redirect_to company_master_path
  end
  
  private
    def company_masters_params
      params.require(:company_master).permit(:company_id, :company_name, :company_owner_name, :company_pan_no, :company_establish_dt, gstins_attributes: [:id, :gstin_no, :_destroy])
    end
    
    def find_company_info
      @company_master = CompanyMaster.find(params[:id])
    end
end
