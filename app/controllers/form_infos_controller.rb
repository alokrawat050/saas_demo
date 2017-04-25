class FormInfosController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :check_multiple_gstin, only: [:index]
  
  def index
    if !params[:id].nil?
      session[:client_id] = params[:id]
      session[:client_name] = params[:client_id]
      @multiple_gstins = Client.includes(:gstins).where(:id => params[:id])
      if !@multiple_gstins.nil?
        @multiple_gstins.each do |x|
          if x.gstins.count == 1
            session[:gstin_id] = x.gstins.first.gstin_no
            flash[:notice] = "You Are Working on GSTIN Number:「 #{x.gstins.first.gstin_no}」"
            redirect_to form_infos_index_path
          else
            redirect_to form_infos_multiple_gstin_path
          end
        end  
      end
    end  
  end
  
  def multiple_gstin
    @multiple_gstins = Client.includes(:gstins).where(:id => session[:client_id])
  end
  
  def gstin_selection
    if user_signed_in?
      session[:gstin_id] = params[:gstin_info]
      #@get_user_pos = MPosition.find(params[:pos_info])
      #session[:pos_name] = @get_user_pos.pos_full_name
      flash[:notice] = "You Are Working on GSTIN Number:「 #{session[:gstin_id]}」"
      redirect_to form_infos_index_path
    end
   end
  
  private
    def check_multiple_gstin
      
    end
end
