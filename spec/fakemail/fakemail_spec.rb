# frozen_string_literal: true

require 'spec_helper'

describe FakeMail do
  it 'invalid email build' do
    value = true
    expect { subject.build_email(extended_for_postmark: value) }
      .to raise_error RuntimeError, "Sending type '#{value}' is incorrect, correct values: [:api, :smtp]"
  end

  it 'build email for Postmark SMTP' do
    email = subject.build_email(extended_for_postmark: :smtp)
    expect(email['PM-EMAIL-TYPE'].to_s).to eq('smtp')
  end

  it 'build email for Postmark API' do
    email = subject.build_email(extended_for_postmark: :api)
    expect(email['PM-EMAIL-TYPE'].to_s).to eq('api')
  end
end
