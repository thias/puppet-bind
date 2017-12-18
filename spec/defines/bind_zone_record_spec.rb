require 'spec_helper'

describe 'bind::zone::record' do
  let(:facts) do {
    :concat_basedir => '/root',
    :osfamily       => 'RedHat'
    }
  end
  let(:title) { 'example.com' }
  let(:params) do
    {
      :target_file => '/etc/bind/db.myzone',
      :rname       => 'host',
      :rdata       => '127.0.0.1',
      :zone_name   => 'example.com'
    }
  end
  let(:pre_condition) { "concat { '/etc/bind/db.myzone':
  ensure => present}" }
  it { should compile }
  it { should contain_concat__fragment('/etc/bind/db.myzone_example.com') }
  it { should contain_assert('Check zone file-/etc/bind/db.myzone-host')}
end
