# Class: bind::params
#
class bind::params {

  case $::osfamily {
    'RedHat': {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $file_hint         = 'named.ca'
      $file_rfc1912      = '/etc/named.rfc1912.zones'
      $checkzone_path    = '/usr/sbin/named-checkzone'
    }
    'Debian': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $file_hint         = '/etc/bind/db.root'
      $file_rfc1912      = '/etc/bind/named.conf.default-zones'
      $checkzone_path    = '/usr/sbin/named-checkzone'
    }
    'Freebsd': {
      $packagenameprefix = 'bind910'
      $servicename       = 'named'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $file_hint         = 'named.ca'
      $file_rfc1912      = '/etc/named.rfc1912.zones'
      $checkzone_path    = '/usr/local/sbin/named-checkzone'
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $file_hint         = 'named.ca'
      $file_rfc1912      = '/etc/named.rfc1912.zones'
      $checkzone_path    = '/usr/sbin/named-checkzone'
    }
  }

}

