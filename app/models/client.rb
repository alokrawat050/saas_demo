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
                            #format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
                            exclusion: {in: RESTRICTED_SUBDOMAIN, message: 'restricted'}
     
    before_validation :downcase_client_name
    
    validates_presence_of   :owner_name, :message => 'Please Enter Owner name.'
    validates_presence_of   :client_pan_no, :message => 'Please Enter Client PAN NO.'
    validates_presence_of   :owner_name, :message => 'Please Enter Owner Name.'
    validates_presence_of   :owner_email, :message => 'Please Enter Owner Email.'
    
    validate :check_email
      def check_email
        unless owner_email.blank?
          if owner_email.present?
            unless owner_email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
                errors.add(:owner_email, "Please Check Email Address.")
            else
                errors.add(:owner_email, "Email Address Domain Does Not Exists.Please Confirm.") unless   validate_email_domain(owner_email)
            end
          end
        end
      end
    
    private
        def downcase_client_name
            self.client_name = client_name.try(:downcase) 
        end
        
        def validate_email_domain(email_id)
            domain = email_id.match(/\@(.+)/)[1]
              Resolv::DNS.open do |dns|
                @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
              end
              @mx.size > 0 ? true : false
          end
end
