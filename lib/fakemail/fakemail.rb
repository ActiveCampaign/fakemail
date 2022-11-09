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
    email_address: 'john@example.com'
  }

  class << self
    def build_email(options = {})
      return build_pm_email(options) if options.keys.include?(:extended_for_postmark)

      FakeMail::Email.email(options)
    end

    private

    def build_pm_email(options = {})
      build_send_type(options.delete(:sending_type)).email(options)
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
