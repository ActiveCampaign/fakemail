require 'spec_helper'

describe FakeMail::Address do
  let(:address) { 'igor@wildbit.com' }

  it '.address' do
    expect(subject.class.address(address: address)).to eq(address)
  end

  it '.address extended length' do
    address_parts = address.split('@')
    expect(subject.class.address(address: address, length: 20)).to match(/#{address_parts[0]}.{4}@#{address_parts[1]}/)
  end

  it '.address extended length - very long' do
    address_parts = address.split('@')
    expect(subject.class.address(address: address, length: 250)).
        to match(/#{address_parts[0]}.{234}@#{address_parts[1]}/)
  end
end