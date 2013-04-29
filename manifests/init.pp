# Class: bind::server
#
# Install and enable an ISC BIND server.
#
# Parameters:
#  $chroot:
#   Enable chroot for the server. Default: false
#  $bindpkgprefix:
#   Package prefix name. Default: 'bind'
#
# Sample Usage :
#  include bind::server
#
#  class { 'bind::server':
#    chroot        => false,
#    bindpkgprefix => 'bind97',
#  }
#
class bind (
  $chroot = false,
  # For RHEL5 you might want to use 'bind97'
  $bindpkgprefix = 'bind'
) {

  $packagenameprefix = $::operatingsystem ? {
    /(Red Hat|Centos|Amazon)/ => 'bind',
    /(Ubuntu|Debian)/ => 'bind9',
    default => 'bind'
  }

  $servicename = $::operatingsystem ? {
    /(Red Hat|Centos|Amazon)/ => 'named',
    /(Ubuntu|Debian)/ => 'bind9',
    default => 'named'
  }

  # Main package and service it provides
  # Assuming the structure bind9-chroot for package name
  $packagenamesuffix = $chroot ? {
    true  => "-chroot",
    false => "",
  }

  $packagename = "${packagenameprefix}${packagenamesuffix}"

  $binduser = $::operatingsystem ? {
    /(Red Hat|Centos|Amazon)/ => 'root',
    /(Ubuntu|Debian)/ => 'bind',
    default => 'root'
  }
  $bindgroup = $::operatingsystem ? {
    /(Red Hat|Centos|Amazon)/ => 'named',
    /(Ubuntu|Debian)/ => 'bind',
    default => 'named'
  }

  # We want a nice log file which the package doesn't provide a location for
  $bindlogdir = $chroot ? {
    true  => '/var/named/chroot/var/log/named',
    false => '/var/log/named',
  }
  file { $bindlogdir:
    require => Class['bind::package'],
    ensure  => directory,
    owner   => $binduser,
    group   => $bindgroup,
    mode    => '0770',
    seltype => 'var_log_t',
  }

  include bind::package, bind::service
}

