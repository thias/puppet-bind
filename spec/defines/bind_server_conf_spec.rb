require 'spec_helper'

describe 'bind::server::conf' do
        let (:pre_condition) { 'class { "bind": }' } 
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
		expect { should contain_file ('/etc/named.conf')}
		content = catalogue.resource('file', '/etc/named.conf').send(:parameters)[:content]
        content.should_not be_empty
        content.should match('acl rfc1918')
        content.should match('masters mymasters')
        content.should match('zone "example.com"')
        content.should match('zone "example.org"')
        content.should match('include "/etc/myzones.conf"')
	end

  describe 'os-dependent-items' do
    let (:params) { { :recursion => 'yes' } }
    context 'on RedHat based systems' do
      let (:title)  { '/etc/named.conf' }
      let (:facts)  { { :osfamily => 'RedHat' } }
      it 'bind configuration should be in line with package defaults' do
        expect { should contain_file ('/etc/named.conf')}
        content = catalogue.resource('file', '/etc/named.conf').send(:parameters)[:content]
        content.should match('file "named.ca"')
        content.should match('include "/etc/named.rfc1912.zones"')
        content.should match('bindkeys-file "/etc/named.iscdlv.key"')
        content.should match('directory "/var/named"')
      end
    end

    context 'on Debian based systems' do
      let (:title)  { '/etc/bind/named.conf' }
      let (:facts)  { { :osfamily => 'debian' } }
      it 'bind configuration should be in line with package defaults' do
        expect { should contain_file ('/etc/named.conf')}
        content = catalogue.resource('file', '/etc/bind/named.conf').send(:parameters)[:content]
        content.should_not match('type hint')
        content.should match('include "/etc/bind/named.conf.default-zones"')
        content.should match('bindkeys-file "/etc/bind/bind.keys"')
        content.should match('directory "/var/cache/bind"')
      end
    end

  end

end

