# Class: bind::params
#
class bind::params {

  case $::operatingsystem {
    'RedHat',
    'CentOS',
    'Amazon': {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $rfc1912_file      = '/etc/named.rfc1912.zones'
    }
    'Debian',
    'Ubuntu': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $rfc1912_file      = '/etc/bind/zones.rfc1918'
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $rfc1912_file      = '/etc/named.rfc1912.zones'
    }
  }

}

