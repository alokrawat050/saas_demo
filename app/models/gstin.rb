class Gstin < ActiveRecord::Base
    belongs_to :company_master
    
    validates_presence_of :gstin_no, :message => 'Please Enter GSTIN NO.'
end
