class DataImportsController < ApplicationController
  def index
    @accounts = Account.all
  end
  
  def export_to_xml1
    @accounts = Account.all
    render :xml => @accounts.to_xml
  end
  
  def export_to_xml2
    @accounts = Account.all
    # send_data @accounts.to_xml,
    #   :type => 'text/xml; charset=UTF-8;',
    #   :disposition => "attachment; filename=accounts.xml"
    
    send_data( @accounts, :type => "text/xml", :filename => "sample.xml" )
  end
  
  def export_to_xml
    doc = Builder::XmlMarkup.new( :target => out_string = "", :indent => 2 )
    @accounts = Account.all
    doc.Account {
      @accounts.each{ |element_data|
      doc.Subdomain( "subdomain_name" => element_data[:subdomain_name],
              "owner_id" => element_data[:owner_id] ){
        doc.Plan_id( element_data[:plan_id] )
        doc.Create_at( element_data[:created_at] )
        }
      } }
    
    send_data( out_string, :type => "text/xml", :filename => "sample.xml" )  
  end
  
end
