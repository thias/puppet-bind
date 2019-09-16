require 'spec_helper'

describe 'bind::server' do
  it { should compile }
  it { should contain_class('bind').with({
    :chroot => false,
    :packagenameprefix => 'bind',
  })}
end
