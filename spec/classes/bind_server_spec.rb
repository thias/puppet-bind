require 'spec_helper'

describe 'bind::server' do
  it 'should compile' do
    expect { should contain_class('bind::server') }
  end

  it 'should create the logging directory' do
  	expect { should contain_file('/var/log/named').with({
  		'ensure' => 'directory',
  		'owner' => 'root',
  		'group' => 'named',
  		'mode' => '0770',
  		'seltype' => 'var_log_t'
  		})}
  end
  context 'on RedHat based systems' do
    let (:facts)  { { :osfamily => 'RedHat' } }
    it { should contain_package('bind').with_ensure('installed') }
    it { should contain_service('named').with({
  	'hasstatus' => true,
  	'enable' => true,
  	'ensure' => 'running',
  	'restart' => 'service named reload'
  	})}
  end
  context 'on debian based systems' do
    let (:facts)  { { :osfamily => 'debian' } }
    it { should contain_package('bind9').with_ensure('installed') }
    it { should contain_service('bind9').with({
  	'hasstatus' => true,
  	'enable' => true,
  	'ensure' => 'running',
  	'restart' => 'service bind9 reload'
  	})}
  end
end

