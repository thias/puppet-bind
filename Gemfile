source ENV['GEM_SOURCE'] || 'https://rubygems.org/'

puppet_ver = ENV['PUPPET_GEM_VERSION'] || '~> 2'

gem 'rspec', '~> 3.1.0'
gem 'rspec-puppet'
gem 'rake'
gem 'puppet', puppet_ver
gem 'puppetlabs_spec_helper'
gem 'puppet-lint'
group :acceptance do
  gem 'beaker-rspec', '~> 5.6', :require => false if RUBY_VERSION > '1.9.0'
  gem 'beaker-pe', :require => false if RUBY_VERSION > '1.9.0'
  gem 'beaker-puppet_install_helper', '~> 0.7.1', :require => false if RUBY_VERSION > '1.9.0'
  gem 'beaker-module_install_helper', '~> 0.1.0', :require => false if RUBY_VERSION > '1.9.0'
  gem 'puppet-examples-helpers', :require => false if RUBY_VERSION > '1.9.0'
end
