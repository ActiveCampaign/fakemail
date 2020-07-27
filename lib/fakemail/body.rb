# frozen_string_literal: true

module FakeMail
  # Body generating helper
  class Body
    def self.html_part
      Mail::Part.new do
        content_type 'text/html; charset=UTF-8'
        body Body.html
      end
    end

    def self.text_part
      Mail::Part.new do
        content_type 'text/plain; charset=UTF-8'
        body Body.text
      end
    end

    def self.html
      %(
            <!DOCTYPE html>
            <html>
            <head>
              <title>Default title</title>
            </head>

            <body>
              <p>#{Body.text}</p>
            </body>
            </html>
      )
    end

    def self.text
      Faker::Lorem.sentences.join('')
    end
  end
end
