# frozen_string_literal: true

module FakeMail
  # Subject helper
  class Subject
    class << self
      def subject
        "QA Shipment for #{Faker::Name.first_name} - #{identifier}"
      end

      private

      def identifier
        Faker::Number.number(digits: 8).to_s
      end
    end
  end
end
