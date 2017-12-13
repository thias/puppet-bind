require 'spec_helper'

describe 'bind::server::file' do

	context 'with source parameter' do
		let(:title) { 'example.com' }
		let (:params) {{
			:source => 'puppet:///modules/bind/named.empty'
		}}
		let(:facts) do {
			:concat_basedir => '/root'
			}
		end

		it { should contain_file('/var/named/example.com') }
	end
	context 'with empty $source, $source_base and $content parameters' do
		let(:title) { 'example.com' }
		let(:facts) do {
			:concat_basedir => '/root'
			}
		end
		it { is_expected.to raise_error(Puppet::Error) }
	end
end
