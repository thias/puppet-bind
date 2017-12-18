source ENV['GEM_SOURCE'] || 'https://rubygems.org/'

puppet_ver = ENV['PUPPET_GEM_VERSION'] || '~> 5'

gem 'rspec', '~> 3.1.0'
gem 'rspec-puppet'
gem 'rake'
gem 'puppet', puppet_ver
gem 'puppetlabs_spec_helper'
gem 'puppet-lint'
group :acceptance do
  gem 'beaker-rspec', :require => false
  gem 'beaker-pe', :require => false
  gem 'beaker-module_install_helper', '~> 0.1.0', :require => false
  gem 'puppet-examples-helpers', :require => false
  gem 'vagrant-wrapper', :require => false
  gem 'vagrant-wrapper', :require => false
end if RUBY_VERSION > '2.1'

group :development do
  gem 'pry'
  gem 'pry-byebug'
end if RUBY_VERSION > '2.1'
