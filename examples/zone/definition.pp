bind::zone::definition { 'world.dev.internal':
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
  'world_dev.internal': rname => '@', rtype => 'NS', rdata => '192.168.56.110';
}
