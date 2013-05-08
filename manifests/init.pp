# Class: bind
#
# Install and enable an ISC BIND server.
#
# Parameters:
#  $chroot:
#   Enable chroot for the server. Default: false
#  $packagenameprefix:
#   Package prefix name. Default: 'bind' or 'bind9' depending on the OS
#  $enable_views:
#   Whether or not to put the hint zone in a view, required if any zones are in views.
#
# Sample Usage :
#  include bind
#  class { 'bind':
#    chroot            => true,
#    packagenameprefix => 'bind97',
#  }
#
# Sample Usage for Hiera:
# ---
# classes:
#   - 'bind'
# bind:
#   chroot: true
#   packagenameprefix: 'bind97'
#
# NOTE: if zone files are to be in a different directory from the named.conf
#      then that directory needs to be declared as a bind::server::file resource
#      bind::server::file {'/etc/zones': ensure=>directory }
class bind (
  $chroot            = false,
  $packagenameprefix = $bind::params::packagenameprefix,
  $owner             = $bind::params::binduser,
  $group             = $bind::params::bindgroup,
  $named_conf        = [],
  $zone_files        = [],
  $enable_vies       = false,
) inherits bind::params {

  # Main package and service
  $packagenamesuffix = $chroot ? {
    true  => '-chroot',
    false => '',
  }
  class { 'bind::package':
    packagenameprefix => $packagenameprefix,
    packagenamesuffix => $packagenamesuffix,
  }
  include bind::service

  # We want a nice log file which the package doesn't provide a location for
  $bindlogdir = $chroot ? {
    true  => '/var/named/chroot/var/log/named',
    false => '/var/log/named',
  }
  file { $bindlogdir:
    require => Class['bind::package'],
    ensure  => directory,
    owner   => $owner,
    group   => $group,
    mode    => '0770',
    seltype => 'var_log_t',
  }

  # The db.root hints file, included automatically in the named.conf
  file { 'db.root':
    owner   => $owner,
    group   => $group,
    mode    => '0444',
    source  => 'puppet:///modules/files/db.root',
  }

  # Import conf file and zone file data from hiera
  create_resources(bind::server::conf,$named_conf)
  create_resources(bind::server::file,$zone_files)

}

