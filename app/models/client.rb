class Client < ApplicationRecord
    secret_key = ENV['PAN_NO_ENCRYPTED_KEY']
    attr_encrypted :client_pan_no, :key => secret_key
    attr_encrypted :gst_password, :key => secret_key
    
    has_many :gstins, class_name: 'Gstin'
    accepts_nested_attributes_for :gstins, allow_destroy: true
    
    RESTRICTED_SUBDOMAIN = %w(www)
    
    validates_presence_of :client_name, :message => 'Please Enter Client Name'
    validates :client_name, presence: true,
                            uniqueness: { case_sensitive: false},
                            format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
                            exclusion: {in: RESTRICTED_SUBDOMAIN, message: 'restricted'}
     
    before_validation :downcase_client_name
    
    validates_presence_of   :owner_name, :message => 'Please Enter Owner name.'
    validates_presence_of   :client_pan_no, :message => 'Please Enter Client PAN NO.'
    
    private
        def downcase_client_name
            self.client_name = client_name.try(:downcase) 
        end
end
