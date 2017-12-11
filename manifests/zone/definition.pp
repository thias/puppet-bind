# == Define: bind::zone::definition
# Creates definition and content preamble for DNS zone
# Define: bind::server::conf
#
# Parameters:
#  $definition_file:
#   full name of the /etc/named.conf.* file,
#  $zone_file:
#   full name of the zone file,
#  $serial:
#   version of zone file
#  $soa_nameserver:
#   domain name, default: localhost
#  $soa_contact:
#   contact to dns admininistrator, default: root.localhost
#  $ttl:
#   time to hold data in cache, default: 604800,
#  $minimum_ttl:
#   minimut time to hold data in cache, default: 604800,
#  $refresh:
#   refresh wait time, default: 604800,
#  $retry:
#   retry wait time, default: 86400,
#  $expire:
#   time after which data is outdated, default: 2419200,
#  $zone_type:
#   wheather zone is master or hint, default: master,
#  $allow_update:
#   hostnames allowed to submit dynamic updates, default: undef,
#  $origin:
#   name of the domain, default: undef,

define bind::zone::definition (
  $definition_file,
  $zone_file,
  $serial,
  $soa_nameserver = 'localhost',
  $soa_contact    = 'root.localhost',
  $ttl            = '604800',
  $minimum_ttl    = '604800',
  $refresh        = '604800',
  $retry          = '86400',
  $expire         = '2419200',
  $zone_type      = 'master',
  $allow_update   = undef,
  $origin         = undef,
){

  case $zone_type {
    'master', 'hint': { info("Supported zone type: ${zone_type}") }
    default: { fail("Unsupported zone type: ${zone_type}") }
  }

  # Add zone definition in $definition_file from bind::server::conf::concat
  concat::fragment { "${definition_file}_${name}":
    target  => $definition_file,
    content => template('bind/zone_definition.erb'),
    order   => '99'
  }
  if $zone_type == 'master' {
    # Create zone configuration file
    concat { $zone_file:
      ensure => 'present',
    }
    concat::fragment { "${zone_file}_01_preamble":
      target  => $zone_file,
      content => template('bind/zone_preamble.erb'),
    }
  }
}
