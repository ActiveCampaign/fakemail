# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/**/*.rb"].sort.each { |f| require f }

require 'configurator'
require 'pry'
require 'faker'
require 'postmark'
require 'mail'

module FakeMail
  # Default config
  class Config
    module POSTMARK
      SENDING_TYPES = %i[api smtp].freeze
    end

    @defaults = nil
    @locale = nil

    class << self
      def defaults
        App.config.files_path = File.join(File.dirname(__FILE__), '../config')
        @defaults || App.config.load!(:defaults)
      end

      def locale=(value)
        Faker::Config.locale = value
      end
    end
  end

  class << self
    def build_email(options = {})
      FakeMail::Email.email(options)
    end

    def build_pm_email(options = {})
      build_send_type(options.delete(:sending_type)).email(options)
    end

    private

    def build_send_type(type)
      raise sending_type_error(type) unless Config::POSTMARK::SENDING_TYPES.include?(type)

      type == :api ? FakeMail::Postmark::API::Email : FakeMail::Postmark::SMTP::Email
    end

    def sending_type_error(type)
      "Sending type '#{type}' is incorrect, correct values: #{Config::POSTMARK::SENDING_TYPES}"
    end
  end
end
