# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fakemail/version'

Gem::Specification.new do |s|
  s.name        = 'fakemail'
  s.version     = FakeMail::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'

  s.authors     = ['Igor Balos']
  s.email       = ['ibalosh@gmail.com', 'igor@wildbit.com']

  s.summary     = 'Email content builder tool.'
  s.description = 'Email content builder tool.'

  s.files       = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.test_files  = `git ls-files -- {spec}/*`.split("\n")
  s.homepage    = 'https://github.com/wildbit/fakemail'
  s.require_paths = ['lib']
  s.required_rubygems_version = '>= 2.6.0'
  s.add_dependency 'secure_yaml'
  s.add_dependency 'faker'
  s.add_dependency 'mail','>= 2.7.1'
  s.add_dependency 'postmark', '>= 1.21.1'
  s.add_dependency 'wbconfigurator'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec'
end
