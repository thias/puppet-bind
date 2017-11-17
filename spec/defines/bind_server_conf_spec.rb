require 'spec_helper'

describe 'bind::server::conf' do
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

	it 'should generate the bind configuration' do
		is_expected.to contain_file ('/etc/named.conf')
		content = catalogue.resource('file', '/etc/named.conf').send(:parameters)[:content]
    expect(content).not_to be_empty
    expect(content).to match('acl rfc1918')
    expect(content).to match('masters mymasters')
    expect(content).to match('zone "example.com"')
    expect(content).to match('zone "example.org"')
    expect(content).to match('include "/etc/myzones.conf"')
	end

end
