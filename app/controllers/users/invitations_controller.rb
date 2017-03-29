module Users
  class InvitationsController < Devise::InvitationsController
    #before_action :authenticate_inviter!
    #private

    #def authenticate_inviter!
    #  authenticate_user!(:force => true)
    #end

    #def authenticate_user!
    #  unless current_user
        #return render json: {
        #  errors: ["Authorized users only."]
        #}, status: 401
    #  end
    #end

    #def resource_class(m=nil)
    #  if m
    #    mapping = Devise.mappings[m]
    #  else
    #    mapping = Devise.mappings[resource_name] || Devise.mappings.values.first
    #  end
    #  mapping.to
    #end

  end
end