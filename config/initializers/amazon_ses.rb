ActionMailer::Base.add_delivery_method :ses,
                                       AWS::SES::Base,
                                       access_key_id: 'your_key',
                                       secret_access_key: 'your_access_key',
                                       server: 'your amazon server'