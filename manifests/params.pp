# Class: bind::params
#
class bind::params {

  case $::os['family'] {
    'RedHat': {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
    }
    'Debian': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $rfc1912_file      = '/etc/bind/zones.rfc1918',
      $root_file         = '/etc/bind/db.root',
    }
    'Freebsd': {
      $packagenameprefix = 'bind910'
      $servicename       = 'named'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $rfc1912_file      = '/etc/named.rfc1912.zones',
      $root_file         = 'named.ca',
    }
  }

}

