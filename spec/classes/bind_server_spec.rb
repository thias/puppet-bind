require 'spec_helper'

describe 'bind::server' do
  it { should contain_class('bind::server') }
  it { should contain_package('bind').with_ensure('installed') }
  it {
    should contain_service('named').
        with('hasstatus' => true,
              'enable' => true,
              'ensure' => 'running',
              'restart' => 'service named reload')
  }
  it { should contain_file('/var/log/named').
    with(
      'ensure' => 'directory',
      'owner' => 'root',
      'group' => 'named',
      'mode' => '0770',
      'seltype' => 'var_log_t'
    )
  }
end
