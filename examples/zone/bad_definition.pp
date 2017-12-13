# Taken from the "Sample Usage :"
# Bug in bind::zone::record. Ther is no A for dns server. Changes won't take effect, because bind service won't be reload
include bind::server
bind::server::conf { '/etc/named.conf':
  acls    => {
    'rfc1918' => [ '10/8', '172.16/12', '192.168/16' ],
  },
  masters => {
    'mymasters' => [ '192.0.2.1', '198.51.100.1' ],
  },
  zones   => {
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
}

bind::zone::definition { 'baddev.internal':
  definition_file => '/etc/named.conf',
  zone_file       => '/var/named/badtest_file.com',
  zone_type       => 'master',
  allow_update    => 'none',
  soa_nameserver  => 'world.baddev.internal',
  soa_contact     => 'badworld.com',
  ttl             => '1800',
  minimum_ttl     => '3H',
  refresh         => '1D',
  retry           => '1H',
  expire          => '1W',
  serial          => '20171208', # for example current date
}

Bind::Zone::Record { target_file => '/var/named/badtest_file.com' }

bind::zone::record {
  'NS_server_node1.baddev.internal': rname => '@', rtype => 'NS', rdata => 'node1.baddev.internal', zone_name => 'baddev.internal';
  'node3.baddev.internal': rname => 'node3', rtype => 'A', rdata => '192.168.32.10', zone_name => 'baddev.internal';
  'node2.baddev.internal': rname => 'node2', rdata => '192.168.32.12', zone_name => 'dev.internal';
}
