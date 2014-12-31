require 'spec_helper'

describe 'bind::server::file' do
  let(:title) { 'example.com' }
  let (:params) {{
    :source => 'puppet:///modules/bind/named.empty'
  }}

  it { should contain_file('/var/named/example.com') }

  context 'RedHat family' do
    let (:facts) { {
      :osfamily => 'RedHat',
    } }

    it { should contain_package('bind') }
  end

  context 'Debian family' do
    let (:facts) { {
      :osfamily => 'Debian',
    } }

    it { should contain_package('bind9') }
  end

  context 'FreeBSD family' do
    let (:facts) { {
      :osfamily => 'Freebsd',
    } }

    it { should contain_package('bind910') }
  end

  context 'Other families' do
    it { should contain_package('bind') }
  end
end
