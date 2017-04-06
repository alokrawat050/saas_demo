class CompanyMaster < ActiveRecord::Base
    secret_key = ENV['PAN_NO_ENCRYPTED_KEY']
    attr_encrypted :company_pan_no, :key => secret_key
    
    has_many :gstins, class_name: 'Gstin'
    accepts_nested_attributes_for :gstins, allow_destroy: true
    
    RESTRICTED_SUBDOMAIN = %w(www)
    
    validates_presence_of :company_name, :message => 'Please Enter Business Name'
    validates :company_name, presence: true,
                            uniqueness: { case_sensitive: false},
                            format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
                            exclusion: {in: RESTRICTED_SUBDOMAIN, message: 'restricted'}
     
    before_validation :downcase_company_name
    
    validates_presence_of   :company_owner_name, :message => 'Please Enter Business owner name.'
    validates_presence_of   :company_pan_no, :message => 'Please Enter Business PAN NO.'
    
    private
        def downcase_company_name
            self.company_name = company_name.try(:downcase) 
        end
end
