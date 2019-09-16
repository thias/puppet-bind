require 'spec_helper'

describe 'bind::service' do
  let (:pre_condition) do
    "include ::bind::package"
  end

  let (:params) do
    {
      :servicename => 'named',
      :service_reload => false,
    }
  end
      
  it { should compile }
  it { should contain_service('named').with({
    'enable' => true,
    'ensure' => 'running',
    'hasstatus' => true,
  })}
end
