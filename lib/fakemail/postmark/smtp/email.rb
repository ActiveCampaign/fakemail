# frozen_string_literal: true

require_relative '../../email'

module FakeMail
  module Postmark
    module SMTP
      # Email content smtp
      class Email < FakeMail::Email
        class << self
          def email(options)
            mail = super(options)
            mail['PM-EMAIL-TYPE'] = 'smtp'
            Settings.tag(mail, options[:tag])
            Settings.metadata(mail, options[:metadata])
            Settings.message_stream(mail, options[:message_stream])
            mail
          end
        end
      end
    end
  end
end
