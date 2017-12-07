# == Define: bind::zone::definition
# Creates definition and content preamble for DNS zone
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
  concat { $definition_file:
    ensure  => present,
    replace => false,
  }
  # Add zone definition in $definition_file
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
