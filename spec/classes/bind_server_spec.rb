require 'spec_helper'

describe 'bind::server' do
  it 'should compile' do
  	expect { should contain_class('bind::server') }
  end
end