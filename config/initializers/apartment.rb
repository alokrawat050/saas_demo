Apartment.configure do |config|
   config.excluded_models = ['CompanyMaster']  # these models will not be multi-tenanted, but remain in the global (public) namespace
   config.tenant_names = -> { CompanyMaster.pluck(:company_name) }
   Apartment::Elevators::Subdomain.excluded_subdomains = ['www']
   Apartment::Elevators::Subdomain.excluded_subdomains = ['gst-alokrawat050']
end