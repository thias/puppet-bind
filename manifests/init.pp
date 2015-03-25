# Class: bind
#
# Install and enable an ISC BIND server.
#
# Parameters:
#  $chroot:
#   Enable chroot for the server. Default: false
#  $packagenameprefix:
#   Package prefix name. Default: 'bind' or 'bind9' depending on the OS
#
# Sample Usage :
#  include bind
#  class { 'bind':
#    chroot            => true,
#    packagenameprefix => 'bind97',
#  }
#
class bind (
  $chroot            = false,
  $service_reload    = true,
  $packagenameprefix = $::bind::params::packagenameprefix,
) inherits ::bind::params {

  # Main package and service
  $packagenamesuffix = $chroot ? {
    true  => '-chroot',
    false => '',
  }
  class { 'bind::package':
    packagenameprefix => $packagenameprefix,
    packagenamesuffix => $packagenamesuffix,
  }
  class { 'bind::service':
    servicename    => $servicename,
    service_reload => $service_reload,
  }

  # We want a nice log file which the package doesn't provide a location for
  $bindlogdir = $chroot ? {
    true  => $::bind::params::chroot_logdir,
    false => $::bind::params::logdir,
  }

  if $binlogdir {
    file { $bindlogdir :
      require => Class['bind::package'],
      ensure  => directory,
      owner   => $::bind::params::binduser,
      group   => $::bind::params::bindgroup,
      mode    => '0770',
      seltype => 'var_log_t',
      before  => Class['bind::service'],
    }
  }
}
