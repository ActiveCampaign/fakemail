# frozen_string_literal: true

require 'spec_helper'

describe FakeMail::Email do
  it '.email - basic email construction' do
    expect(subject.class.email(body: 'test').body.to_s).to eq('test')
  end

  it '.email - default from address' do
    aggregate_failures do
      expect(subject.class.email(body: 'test')[:from].to_s).not_to be nil
      expect(subject.class.email(body: 'test')[:from].to_s).to eq(FakeMail::DEFAULTS[:from])
    end
  end

  it '.email - custom default from address' do
    FakeMail::DEFAULTS[:from] = 'defaults_custom@example.com'
    expect(subject.class.email(body: 'test')[:from].to_s).to eq('defaults_custom@example.com')
  end

  it '.email - custom from address' do
    expect(subject.class.email(from: 'custom@example.com')[:from].to_s).to eq('custom@example.com')
  end

  it '.email - default to address' do
    aggregate_failures do
      expect(subject.class.email(body: 'test')[:to].to_s).not_to be nil
      expect(subject.class.email(body: 'test')[:to].to_s).to eq(FakeMail::DEFAULTS[:to])
    end
  end

  it '.email - custom default to address' do
    FakeMail::DEFAULTS[:to] = 'defaults_custom_to@example.com'
    expect(subject.class.email(body: 'test')[:to].to_s).to eq('defaults_custom_to@example.com')
  end

  it '.email - custom to address' do
    FakeMail::DEFAULTS[:to] = 'defaults_custom_to@example.com'
    expect(subject.class.email(body: 'test', to: 'test@example.com')[:to].to_s).to eq('test@example.com')
  end

  # if any recipient is specified, default to: recipient is not used
  it '.email - custom cc address' do
    FakeMail::DEFAULTS[:to] = 'defaults_custom_to@example.com'

    email = subject.class.email(body: 'test', cc: 'testcc@example.com')
    aggregate_failures do
      expect(email.to).to be_nil
      expect(email.bcc).to be_nil
      expect(email[:cc].to_s).to eq('testcc@example.com')
    end
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
