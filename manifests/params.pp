# Class: bind::params
#
class bind::params {

  case $::osfamily {
    'RedHat': {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $directory         = '/var/named'
      $zonedir           = '/var/named'
      $rfc1912_zones     = '/etc/named.rfc1912.zones'
      $bindkeys_file     = '/etc/named.iscdlv.key'
    }
    'Debian': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $directory         = '/var/cache/bind'
      $zonedir           = '/etc/bind'
      $rfc1912_zones     = '/etc/bind/named.conf.default-zones'
      $bindkeys_file     = '/etc/bind/bind.keys'
    }
    'Freebsd': {
      $packagenameprefix = 'bind910'
      $servicename       = 'named'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $directory         = '/var/named'
      $zonedir           = '/var/named'
      $rfc1912_zones     = '/etc/named.rfc192.zones'
      $bindkeys_file     = '/etc/named.iscdlv.key'
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $directory         = '/var/named'
      $zonedir           = '/var/named'
      $rfc1912_zones     = '/etc/named.rfc1912.zones'
      $bindkeys_file     = '/etc/named.iscdlv.key'
    }
  }

}

