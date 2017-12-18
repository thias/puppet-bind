# Define: bind::server::file
#
# ISC BIND server template-based or pre-created zone file definition.
# Either of $source or $content must be specificed when using it.
#
# Parameters:
#  $zonedir:
#    Directory where to store the zone file. Default: '/var/named'
#  $owner:
#    Zone file user owner. Default: 'root'
#  $group:
#    Zone file group owner. Default: 'named'
#  $mode:
#    Zone file mode: Default: '0640'
#  $source:
#    Zone file content source. Default: none
#  $source_base:
#    Zone file content source base, where to look for a file named the same as
#    the zone itselt. Default: none
#  $content:
#    Zone file content (usually template-based). Default: none
#  $ensure:
#    Whether the zone file should be 'present' or 'absent'. Default: present.
#  $order:
#    Order the fragments. Default: '15'
#
# Sample Usage :
#  bind::server::file { 'example.com':
#    zonedir => '/var/named',
#    source  => 'puppet:///files/dns/example.com',
#  }
#
define bind::server::file (
  $zonedir     = '/var/named',
  $owner       = 'root',
  $mode        = '0640',
  $dirmode     = '0750',
  $order       = '15',
  $ensure      = undef,
  $group       = undef,
  $source      = undef,
  $source_base = undef,
  $content     = undef,

) {

  include ::bind::params
  include ::bind

  if $group {
    $bindgroup = $group
  } else {
    $bindgroup = $::bind::params::bindgroup
  }

  if $source {
    $zone_source = $source
  } elsif $source_base {
    $zone_source = "${source_base}${title}"
  } else {
    $zone_source = undef
  }

  if ! defined(File[$zonedir]) {
    file { $zonedir:
      ensure => directory,
      owner  => $owner,
      group  => $bindgroup,
      mode   => $dirmode,
    }
  }
  $file_zone = "${zonedir}/${title}"

  concat { $file_zone:
    ensure => $ensure,
    owner  => $owner,
    group  => $bindgroup,
    mode   => $mode,
  }
  if $zone_source {
    $content_file = $zone_source
  }
  elsif $content {
    $content_file = $zone_source
  }
  else {
    fail('One of $source, $source_base and $content parametres must be given')
  }
  concat::fragment { "${file_zone}_01_preamble":
    target  => $file_zone,
    source  => $content_file,
    order   => $order,
    notify  => Class['::bind::service'],
    require => [
    Class['::bind::package'],
    File[$zonedir],
    ],
  }
}
