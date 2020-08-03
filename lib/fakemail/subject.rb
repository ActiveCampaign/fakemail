# frozen_string_literal: true

module FakeMail
  # Subject helper
  class Subject
    class << self
      def subject(id_length: 8)
        subscription(id_length: id_length)
      end

      private

      def subscription(id_length: 8)
        "Subscription #{identifier(length: id_length)} for #{Faker::Name.first_name} is #{Faker::Subscription.status}"
      end

      def identifier(length: 8)
        Faker::Number.number(digits: length).to_s
      end
    end
  end
end
