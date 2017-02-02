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
#  $packagenameprefix:
#    The name of the package providing the bind service. Default: osfamily-dependent
#
# Sample Usage :
#  bind::server::file { 'example.com':
#    zonedir => '/var/named',
#    source  => 'puppet:///files/dns/example.com',
#  }
#
define bind::server::file (
  $zonedir           = '/var/named',
  $owner             = 'root',
  $group             = undef,
  $mode              = '0640',
  $dirmode           = '0750',
  $source            = undef,
  $source_base       = undef,
  $content           = undef,
  $ensure            = undef,
  $packagenameprefix = $::bind::params::packagenameprefix,
) {
  include ::bind
  include '::bind::params'

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

  file { "${zonedir}/${title}":
    ensure  => $ensure,
    owner   => $owner,
    group   => $bindgroup,
    mode    => $mode,
    source  => $zone_source,
    content => $content,
    notify  => Class['::bind::service'],
    # For the parent directory
    require => [
      Package[$packagenameprefix],
      File[$zonedir],
    ],
  }

}
