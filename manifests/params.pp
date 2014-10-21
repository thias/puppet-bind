# Class: bind::params
#
class bind::params {

  case $::osfamily {
    'RedHat': {
      $packagenameprefix       = 'bind'
      $servicename             = 'named'
      $binduser                = 'root'
      $bindgroup               = 'named'
      $service_restart_command = "service ${servicename} reload"
    }
    'Debian': {
      $packagenameprefix       = 'bind9'
      $servicename             = 'bind9'
      $binduser                = 'bind'
      $bindgroup               = 'bind'
      $service_restart_command = "service ${servicename} reload"
    }
    'Freebsd': {
      $packagenameprefix       = 'bind910'
      $servicename             = 'named'
      $binduser                = 'bind'
      $bindgroup               = 'bind'
    }
    default: {
      $packagenameprefix       = 'bind'
      $servicename             = 'named'
      $binduser                = 'root'
      $bindgroup               = 'named'
      $service_restart_command = "service ${servicename} reload"
    }
  }

}

