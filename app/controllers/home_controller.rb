class HomeController < ApplicationController
  before_action :authenticate_user!, :is_payment_info_submit
  
  def index
  end
end
