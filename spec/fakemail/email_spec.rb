# frozen_string_literal: true

require 'spec_helper'

describe FakeMail::Email do
  it '.email - basic email construction' do
    expect(subject.class.email(body: 'test').body.to_s).to eq('test')
  end

  context 'attachments' do
    it '.email - load attachments from files' do
      filename = 'README.md'
      files = [File.join(File.dirname(__FILE__), "../../#{filename}")]
      email = subject.class.email(body: 'test', attachment_files: files)

      aggregate_failures do
        expect(email.attachments.size).to eq(1)
        expect(email.attachments.first.filename).to eq(filename)
      end
    end

    it '.email - load attachments content' do
      attachments = [
        { name: 'test1.txt', value: 'test1' },
        { name: 'test2.txt', value: 'test2' }
      ]

      email = subject.class.email(body: 'test', attachments: attachments)

      aggregate_failures do
        expect(email.attachments.size).to eq(2)
        expect(email.html_part.body.to_s).to eq('test')
        expect(email.attachments.map { |a| a.filename }).to match_array(%w[test1.txt test2.txt])
      end
    end
  end
end
