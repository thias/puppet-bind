require 'puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'
require 'puppet-examples-helpers'

UNSUPPORTED_PLATFORMS = %w[Suse windows AIX Solaris].freeze

install_puppet({
  :version              => ENV['PUPPET_INSTALL_VERSION'] || '4',
  :puppet_agent_version => ENV['PUPPET_AGENT_INSTALL_VERSION'] || '1.10.7',
  :puppet_collection    => ENV['PUPPET_COLLECTION'] || 'pc1',
  :default_action       => 'gem_install'
})
shell 'echo "Puppet Version: $(puppet --version)"'
install_module
install_module_dependencies

RSpec.configure do |c|
  c.include PuppetExamplesHelpers

  c.order     = :defined
end
