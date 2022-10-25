# frozen_string_literal: true

require 'spec_helper'

describe FakeMail::Address do
  let(:address) { 'ibalos@activecampaign.com' }

  it '.address' do
    expect(subject.class.address(address: address)).to eq(address)
  end

  it '.address extended length' do
    address_parts = address.split('@')
    aggregate_failures do
      expect(subject.class.address(address: address, length: 50)).to match(/#{address_parts[0]}+.+@#{address_parts[1]}/)
      expect(subject.class.address(address: address, length: 50).size).to eq(50)
    end
  end

  it '.address extended length - very long' do
    address_parts = address.split('@')
    aggregate_failures do
      expect(subject.class.address(address: address, length: 250))
        .to match(/#{address_parts[0]}+.+@#{address_parts[1]}/)
      expect(subject.class.address(address: address, length: 250).size).to eq(250)
    end
  end
end
