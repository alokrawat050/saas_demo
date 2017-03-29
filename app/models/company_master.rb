class CompanyMaster < ActiveRecord::Base
    RESTRICTED_SUBDOMAIN = %w(www)
    
    belongs_to :owner, class_name: 'User'
    #validates :owner, presence: true
    
    validates :company_name, presence: true,
                            uniqueness: { case_sensitive: false},
                            format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
                            exclusion: {in: RESTRICTED_SUBDOMAIN, message: 'restricted'}
     
    accepts_nested_attributes_for :owner
                            
    before_validation :downcase_company_name
    
    private
        def downcase_company_name
            self.company_name = company_name.try(:downcase) 
        end
end
