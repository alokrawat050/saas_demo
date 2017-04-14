ActionMailer::Base.add_delivery_method :ses,
                                       AWS::SES::Base,
                                       access_key_id: 'AKIAIIKRMOE66BCAWHMQ',
                                       secret_access_key: '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',
                                       server: 'email.us-east-1.amazonaws.com'