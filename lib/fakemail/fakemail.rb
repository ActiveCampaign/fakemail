# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/**/*.rb"].sort.each { |f| require f }

require 'pry'
require 'faker'
require 'postmark'
require 'mail'

module FakeMail
  module POSTMARK
    SENDING_TYPES = %i[api smtp].freeze
  end

  DEFAULTS = {
    to: 'to@example.com',
    from: 'from@example.com',
    email_address: 'john@example.com'
  }

  class << self
    # options that can be passed to fakemail
    # ------------------------
    ## postmark options
    # ------------------------
    # extended_for_postmark: :api (or :smtp) - email will be modified for postmark
    # sending_type: :api - adjust email for postmark api, goes with above
    # ------------------------
    # email general options
    # ------------------------
    # body: content - any body
    # html_part: content - html body
    # text_part: content - text body
    # text_and_html: true - add default text and html content
    # from: address
    # to:,cc:,bcc: address
    # reply_to: address
    # subject: value
    # attachment_files: ['file1', 'file2']
    # attachments: [{name: 'file1', value: 'content'}]

    def build_email(options = {})
      set_default_multipart_bodies(options) if options.delete(:text_and_html)
      return build_pm_email(options) if options.keys.include?(:extended_for_postmark)

      FakeMail::Email.email(options)
    end

    private

    def set_default_multipart_bodies(options)
      options[:html_part] = options[:html_part] || 'html part'
      options[:text_part] = options[:text_part] || 'text part'
      options
    end

    def build_pm_email(options = {})
      build_send_type(options.delete(:extended_for_postmark)).email(options)
    end

    def build_send_type(type)
      raise sending_type_error(type) unless POSTMARK::SENDING_TYPES.include?(type)

      type == :api ? FakeMail::Postmark::API::Email : FakeMail::Postmark::SMTP::Email
    end

    def sending_type_error(type)
      "Sending type '#{type}' is incorrect, correct values: #{POSTMARK::SENDING_TYPES}"
    end
  end
end
