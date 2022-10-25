# frozen_string_literal: true

module FakeMail
  # Attachments helper
  class Attachment
    class << self
      def add_attachments_by_content(email, attachments = [])
        attachments.to_a.each { |h| add_attachment_by_content(email, h[:name], h[:value]) }
      end

      def add_attachment_by_content(email, filename, data)
        # check Mail::Message.attachments for details
        email.attachments[filename] = data
      end

      def add_attachments_by_filename(email, files)
        return if files.nil? || files.empty?

        Array(files).each do |path|
          filename, content = attachment_filename_content(path)
          email.attachments[filename] = content
        end
      end

      protected

      def attachment_filename_content(path)
        file = File.open(path)
        filename = File.basename(file)
        content = File.read(file)
        [filename, content]
      end
    end
  end
end
