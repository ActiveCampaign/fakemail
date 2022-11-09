# frozen_string_literal: true

require 'rspec'
require 'mail'
require 'postmark'
require 'pry'
require 'fakemail'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

RSpec.configure do |c|
  # Use the specified formatter, options are: # :documentation, :progress, :html, :textmate
  c.formatter = :documentation
  c.color = true
end
