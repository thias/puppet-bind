# Taken from the "Sample Usage :"
include bind::server
bind::server::conf { '/etc/named.conf':
  recursion => 'no',
  acls      => {
    'rfc1918' => [ '10/8', '172.16/12', '192.168/16' ],
  },
  masters   => {
    'mymasters' => [ '192.0.2.1', '198.51.100.1' ],
  },
  zones     => {
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

bind::zone::definition { 'dev.internal':
  definition_file => '/etc/named.conf',
  zone_file       => '/var/named/test_file.com',
  zone_type       => 'master',
  allow_update    => 'none',
  soa_nameserver  => 'world.dev.internal',
  soa_contact     => 'world.com',
  ttl             => '1800',
  minimum_ttl     => '3H',
  refresh         => '1D',
  retry           => '1H',
  expire          => '1W',
  serial          => '20171208', # for example current date
}

Bind::Zone::Record { target_file => '/var/named/test_file.com' }

bind::zone::record {
  'NS_server_node1.dev.internal': rname => '@', rtype => 'NS', rdata => 'node1.dev.internal', zone_name => 'dev.internal';
  'node1.dev.internal': rname => 'node1', rtype => 'A', rdata => '192.168.33.10', zone_name => 'dev.internal';
  'node2.dev.internal': rname => 'node2', rdata => '192.168.33.12', zone_name => 'dev.internal';
}
