require 'puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'
require 'puppet-examples-helpers'

UNSUPPORTED_PLATFORMS = %w[Suse windows AIX Solaris].freeze

run_puppet_install_helper
install_module
install_module_dependencies

RSpec.configure do |c|
  c.include PuppetExamplesHelpers

  c.formatter = :documentation
  c.order     = :defined
end
