require 'spec_helper'

describe 'bind::zone::definition'  do
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
  it { should compile }
  it { is_expected.to contain_file('/etc/bind/named.conf.unit') }
  it { is_expected.to contain_file('/etc/bind/coi/db.myzone') }
end
