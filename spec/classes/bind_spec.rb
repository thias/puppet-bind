require 'spec_helper'

describe 'bind' do
  it { should compile }
  it { should contain_class('bind::package') }
  it { should contain_class('bind::service') }

  it { should contain_file('/var/log/named').with({
      'ensure' => 'directory',
      'owner' => 'root',
      'group' => 'named',
      'mode' => '0770',
      'seltype' => 'var_log_t',
  })}
end
