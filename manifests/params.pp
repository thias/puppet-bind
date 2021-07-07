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
      if versioncmp($::operatingsystemrelease, '8') >= 0 {
        $file_bindkeys   = '/etc/named.root.key'
      } else {
        $file_bindkeys   = '/etc/named.iscdlv.key'
      }
    }
    'Debian': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      case $facts['lsbdistcodename'] {
        # newer Debian releases include the hint in the named.conf.default-zones
        # bind fails to start with duplicate declarations
        /^(stretch|bionic|cosmic)$/: {
          $file_hint = undef
        }
        default: {
          $file_hint = '/etc/bind/db.root'
        }
      }
      $file_rfc1912      = '/etc/bind/named.conf.default-zones'
      $file_bindkeys     = '/etc/named.iscdlv.key'
    }
    'Freebsd': {
      $packagenameprefix = 'bind910'
      $servicename       = 'named'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $file_hint         = 'named.ca'
      $file_rfc1912      = '/etc/named.rfc1912.zones'
      $file_bindkeys     = '/etc/named.iscdlv.key'
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $file_hint         = 'named.ca'
      $file_rfc1912      = '/etc/named.rfc1912.zones'
      $file_bindkeys     = '/etc/named.iscdlv.key'
    }
  }

}

