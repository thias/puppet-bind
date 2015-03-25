# Class: bind::params
#
class bind::params {

  case $::osfamily {
    'RedHat': {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $logdir            = '/var/log/named'
      $chroot_logdir     = '/var/named/chroot/var/log/named'
    }
    'Debian': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $logdir            = undef
      $chroot_logdir     = '/var/chroot/named/var/log/bind'
    }
    'Freebsd': {
      $packagenameprefix = 'bind910'
      $servicename       = 'named'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $logdir            = '/var/log/named'
      $chroot_logdir     = '/var/named/chroot/var/log/named'
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $logdir            = '/var/log/named'
      $chroot_logdir     = '/var/named/chroot/var/log/named'
    }
  }

}
