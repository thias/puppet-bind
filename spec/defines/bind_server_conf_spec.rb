require 'spec_helper'

describe 'bind::server::conf' do
	let(:facts) do {
    :concat_basedir => '/root'
    }
  end
	let (:title)  { '/etc/named.conf' }
	let (:params) { {
		:acls => {
			'rfc1918' => [ '10/8', '172.16/12', '192.168/16' ]
		},
		:masters => {
			'mymasters' => ['192.0.2.1', '198.51.100.1']
		},
		:zones => {
			'example.com' => [
				'type master',
				'file "example.com"',
			],
			'example.org' => [
				'type slave',
				'file "slaves/example.org"',
				'masters { mymasters; }',
			],
		},
		:includes => [
			'/etc/myzones.conf',
		],
	} }

	context 'should generate the bind configuration with concat' do
		it { is_expected.to contain_file('/etc/named.conf') }
		it { is_expected.to contain_concat('/etc/named.conf') }
		end
	end
