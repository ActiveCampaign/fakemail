# frozen_string_literal: true

module FakeMail
  # Email generating helper
  class Email
    class << self
      def email(options)
        mail = build_base_email(options)
        set_body(mail, options[:body], options[:text_part], options[:html_part])
        Attachment.add_attachments_by_filename(mail, options[:attachment_files])
        Attachment.add_attachments_by_content(mail, options[:attachments])
        mail
      end

      private

      def build_base_email(options)
        mail = Mail.new
        mail['SENT-AT-DATE'] = Time.now.strftime '%a, %d %b %Y %H:%M:%S %z'
        mail.subject = options[:subject] || Subject.subject
        mail.from = options[:from] || Address.address
        mail.reply_to = options[:reply_to]
        build_recipients(mail, options)
        mail
      end

      def build_recipients(mail, options)
        mail.to = options[:to]
        mail.cc = options[:cc]
        mail.bcc = options[:bcc]
        mail.to == Address.address if mail.to || mail.cc || mail.bcc
      end

      def set_body(mail, body, text_part, html_part)
        if html_part.nil? && text_part.nil?
          mail.body = body || Body.html
          mail.content_type = 'text/html; charset=UTF-8'
        elsif html_part.nil?
          mail.body = text_part
          mail.content_type = 'text/plain; charset=UTF-8'
        elsif text_part.nil?
          mail.body = html_part
          mail.content_type = 'text/html; charset=UTF-8'
        else
          mail.html_part = html_part
          mail.text_part = text_part
        end
      end
    end
  end
end
