# frozen_string_literal: true

module FakeMail
  module Postmark
    module SMTP
      # Base email settings
      class Settings
        class << self
          def tag(email, value)
            return if value.nil?

            email[HEADER_NAMES[:TAG]] = value
          end

          def metadata(email, hash)
            return if hash.nil?

            hash.each { |key, value| email["#{HEADER_NAMES[:METADATA]}-#{key}"] = value }
          end

          def track_opens(email, value)
            return if value.nil?

            email[HEADER_NAMES[:TRACK_OPENS]] = value
          end

          def track_links(email, value)
            return if value.nil?

            email[HEADER_NAMES[:TRACK_LINKS]] = TRACK_LINK_VALUES[value]
          end

          def message_stream(email, value)
            return if value.nil?

            email[HEADER_NAMES[:MESSAGE_STREAM]] = value
          end

          TRACK_LINK_VALUES = {
            html_and_text: 'HtmlAndText',
            html_only: 'HtmlOnly',
            text_only: 'TextOnly',
            none: 'None'
          }.freeze

          HEADER_NAMES = {
            TAG: 'X-PM-Tag',
            METADATA: 'X-PM-MetaData',
            TRACK_LINKS: 'X-PM-TrackLinks',
            TRACK_OPENS: 'X-PM-TrackOpens',
            MESSAGE_STREAM: 'X-PM-Message-Stream'
          }.freeze
        end
      end
    end
  end
end
