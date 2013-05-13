# Define: bind::server::file
#
# ISC BIND server template-based or pre-created zone file definition.
# Either of $source or $content must be specificed when using it.
#
# Parameters:
#  $directory:
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
#
# Sample Usage :
#  bind::server::file { 'example.com':
#    directory => '/var/named/chroot/var/named',
#    source    => 'puppet:///files/dns/example.com',
#  }
#
# Sample Usage for Hiera (resources created in main bind class):
# bind::server_files:
#   example.com:
#    directory: '/var/named/chroot/var/named'
#    source:    'puppet:///files/dns/example.com'
#
define bind::server::file (
  $zonedir     = undef,
  $directory   = undef,
  $owner       = undef,
  $group       = undef,
  $mode        = '0640',
  $source      = undef,
  $source_base = undef,
  $content     = undef,
  $ensure      = undef
) {
  include bind::params

  # If owner is declared with the resource use that, otherwise the defaults.
  if $owner { $fowner = $owner } else { $fowner = $bind::params::binduser }
  if $group { $fgroup = $group } else { $fgroup = $bind::params::bindgroup }

  # Maintain compatibility with $zonedir
  if    $zonedir   { $destdir = $zonedir }
  elsif $directory { $destdir = $directory }

  if $source      { $zone_source = $source }
  if $source_base { $zone_source = "${source_base}/${title}" }

  file { "${destdir}/${title}":
    owner   => $fowner,
    group   => $fgroup,
    mode    => $mode,
    source  => $zone_source,
    content => $content,
    ensure  => $ensure,
    notify  => Class['bind::service'],
    # For the parent directory
    require => Class['bind::package'],
  }

}

