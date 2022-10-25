# frozen_string_literal: true

require 'spec_helper'

describe FakeMail::Email do
  it '.email - basic email construction' do
    expect(subject.class.email(body: 'test').body.to_s).to eq('test')
  end
end
