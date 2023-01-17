# frozen_string_literal: true

module FakeMail
  # Email generating helper
  class Email
    class << self
      def email(options)
        mail = build_base_email(options)
        set_body(part_to_append_body_to(mail, options), options[:body], options[:text_part], options[:html_part])
        Attachment.add_attachments_by_filename(mail, options[:attachment_files])
        Attachment.add_attachments_by_content(mail, options[:attachments])
        mail
      end

      private

      def build_base_email(options)
        mail = Mail.new
        mail['SENT-AT-DATE'] = Time.now.strftime '%a, %d %b %Y %H:%M:%S %z'
        mail.subject = options[:subject] || Subject.subject
        mail.from = options[:from] || DEFAULTS[:from]
        mail.reply_to = options[:reply_to]
        build_recipients(mail, options)
        mail
      end

      def build_recipients(mail, options)
        mail.to = options[:to]
        mail.cc = options[:cc]
        mail.bcc = options[:bcc]

        mail.to = DEFAULTS[:to] if mail.to.nil? && mail.cc.nil? && mail.bcc.nil?
      end

      def part_to_append_body_to(mail, options)
        mail_or_part = mail
        mail.part { |part| mail_or_part = part } if options.keys.to_s.include?('attachment')
        mail_or_part
      end

      def set_body(mail_or_part, body, text_part, html_part)
        if html_part.nil? && text_part.nil?
          mail_or_part.body = body || Body.html
          mail_or_part.content_type = 'text/html; charset=UTF-8'
        elsif html_part.nil?
          mail_or_part.body = text_part
          mail_or_part.content_type = 'text/plain; charset=UTF-8'
        elsif text_part.nil?
          mail_or_part.body = html_part
          mail_or_part.content_type = 'text/html; charset=UTF-8'
        else
          mail_or_part.html_part = html_part
          mail_or_part.text_part = text_part
        end
      end
    end
  end
end
