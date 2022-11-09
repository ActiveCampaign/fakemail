# frozen_string_literal: true

require 'spec_helper'

describe FakeMail do
  it 'invalid email build' do
    expect { subject.build_email(sending_type: :test, extended_for_postmark: true) }
      .to raise_error RuntimeError, "Sending type 'test' is incorrect, correct values: [:api, :smtp]"
  end

  it 'build email for Postmark SMTP' do
    email = subject.build_email(sending_type: :smtp, extended_for_postmark: true)
    expect(email['PM-EMAIL-TYPE'].to_s).to eq('smtp')
  end

  it 'build email for Postmark API' do
    email = subject.build_email(sending_type: :api, extended_for_postmark: true)
    expect(email['PM-EMAIL-TYPE'].to_s).to eq('api')
  end
end
