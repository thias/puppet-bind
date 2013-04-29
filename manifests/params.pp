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
    }
    'Debian',
    'Ubuntu': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
    }
  }

}

