xml.instruct!
xml.accounts do
  @accounts.each do |account|
    xml.account do
      xml.subdomain_name account.subdomain_name
      xml.owner_id account.owner_id
      xml.plan_id account.plan_id
    end
  end

end