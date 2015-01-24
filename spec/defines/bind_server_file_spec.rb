require 'spec_helper'

describe 'bind::server::file' do
    let (:pre_condition) { 'class { "bind": }' }
    context 'on RedHat based systems' do
        let (:facts)  { { :osfamily => 'RedHat' } }

	let(:title) { 'example.com' }
	let (:params) {{
		:source => 'puppet:///modules/bind/named.empty'
	}}

	it { should contain_file('/var/named/example.com') }
    end

    context 'on Debian based systems' do
        let (:facts)  { { :osfamily => 'debian' } }

        let(:title) { 'example.com' }
        let (:params) {{
                :source => 'puppet:///modules/bind/named.empty'
        }}

        it { should contain_file('/var/cache/bind/example.com') }
    end

end

