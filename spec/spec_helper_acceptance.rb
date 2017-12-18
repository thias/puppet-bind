require 'puppet'
require 'beaker-rspec'
require 'beaker/module_install_helper'
require 'puppet-examples-helpers'
require 'spec_helper'

UNSUPPORTED_PLATFORMS = %w[Suse windows AIX Solaris].freeze

puppet_version = ENV['PUPPET_INSTALL_VERSION'] || '4'
puppet_agent_version = ENV['PUPPET_AGENT_INSTALL_VERSION'] || '1.10.7'
opts = {
  :version              => puppet_version,
  :puppet_agent_version => puppet_agent_version
}
opts.merge!({
  :puppet_collection => ENV['PUPPET_COLLECTION']
}) unless ENV['PUPPET_COLLECTION'].nil?

install_puppet opts
shell 'echo "Puppet Version: $(puppet --version)"'
install_module
install_module_dependencies

RSpec.configure do |c|
  c.include PuppetExamplesHelpers

  c.order     = :defined
end
