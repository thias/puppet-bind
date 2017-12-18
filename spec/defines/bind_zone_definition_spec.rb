require 'spec_helper'

describe 'bind::zone::definition'  do
  let(:pre_condition) { 'include bind::params'}
  let(:facts) do {
    :concat_basedir => '/root'
    }
  end
  let(:title) { 'localhost.org' }
  let(:params) do
    {
      :definition_file => '/etc/bind/named.conf.unit',
      :zone_file       => '/etc/bind/coi/db.myzone',
      :serial          => '20160501'
    }
  end
  let(:pre_condition) { "concat { '/etc/bind/named.conf.unit':
  ensure => present}" }
  it { should compile }
  it { is_expected.to contain_file('/etc/bind/named.conf.unit') }
  it { is_expected.to contain_file('/etc/bind/coi/db.myzone') }
  it { is_expected.to contain_assert('Check nameserver file-/etc/bind/named.conf.unit')}
end
