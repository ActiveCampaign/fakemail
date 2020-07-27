# frozen_string_literal: true

module FakeMail
  module Postmark
    module API
      # Settings api
      class Settings
        class << self
          def tag(email, value)
            return if value.nil?

            email.tag = value
          end

          def metadata(email, hash)
            return if hash.nil?

            email.metadata = hash
          end

          def track_opens(email, value)
            return if value.nil?

            email.track_opens = value
          end

          def track_links(email, value)
            return if value.nil?

            email.track_links = value
          end

          def message_stream(email, value)
            return if value.nil?

            email.message_stream = value
          end
        end
      end
    end
  end
end
