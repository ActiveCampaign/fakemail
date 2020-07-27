# frozen_string_literal: true

module FakeMail
  # Attachments helper
  class Attachment
    class << self
      def add_attachment_contents(email, name_content = {})
        return if name_content.nil?

        name_content.each { |hash| email.attachments[hash['Name']] = hash['Value'] }
      end

      def add_attachment_content(email, filename, content)
        email.attachments[filename] = content
      end

      def add_attachment_files(email, files)
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
