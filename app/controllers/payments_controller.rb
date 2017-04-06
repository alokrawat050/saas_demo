class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  # GET /payments/new
  def new
    #plan = Plan.find(params[:plan_id])
    #@payment = plan.payments.build
    @payment = Payment.new
  end

  def create
    if stripe_token = params[:stripe_token]
      if current_user.do_deposit_transaction(params[:payment_type], stripe_token)
        @payment = Payment.new(payment_params)
        @payment.assign_attributes(:created_by => current_user.username)
          if @payment.save
            flash[:notice] = 'Card charged successfully'
          end
      else
        flash[:alert] = 'Some error happened while charging you, please double check your card details'
      end
    else
      flash[:alert] = 'You did not submit the form correctly'
    end

    redirect_to new_payment_path
  end
  
  private
    def payment_params
      params.require(:payment).permit(:account_id)
    end
    
    def find_company_info
      @payment = Payment.find(params[:id])
    end
end
