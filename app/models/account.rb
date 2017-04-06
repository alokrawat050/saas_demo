class Account < ActiveRecord::Base
    RESTRICTED_SUBDOMAIN = %w(www)
    
    belongs_to :owner, class_name: 'User'
    #validates :owner, presence: true
    accepts_nested_attributes_for :owner, allow_destroy: true
    
    validates :subdomain_name, presence: true,
                            uniqueness: { case_sensitive: false},
                            format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
                            exclusion: {in: RESTRICTED_SUBDOMAIN, message: 'restricted'}
                            
    before_validation :downcase_account
    
    private
        def downcase_account
            self.subdomain_name = subdomain_name.try(:downcase) 
        end
end
