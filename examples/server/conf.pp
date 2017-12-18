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
bind::server::file { 'example.com':
  source => 'puppet:///modules/bind/named.empty',
}
Bind::Zone::Record { target_file => '/var/named/example.com' }

bind::zone::record {
  'NS_server_world1.example.com': rname => '@', rtype => 'NS', rdata => 'world1.example.com', zone_name => 'example.com';
  'world1.example.com': rname => 'world1', rtype => 'A', rdata => '192.168.56.110', zone_name => 'example.com';
  'world2.example.com': rname => 'world2', rdata => '192.168.56.112', zone_name => 'example.com';
}
