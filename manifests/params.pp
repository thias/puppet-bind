# Class: bind::params
#
class bind::params {

  case $::osfamily {
    'RedHat': {
      $packagenameprefix       = 'bind'
      $servicename             = 'named'
      $binduser                = 'root'
      $bindgroup               = 'named'
      $bindkeysfile            = '/etc/named.iscdlv.key'
      $directory               = '/var/named'
      $dump_dir                = '/var/named/data'
      $hintsfile               = 'named.ca'
      $rfc1912zones            = '/etc/named.rfc1912.zones'
      $zonedir                 = '/var/named'
	  $service_restart_command = "service ${servicename} reload"
    }
    'Debian': {
      $packagenameprefix       = 'bind9'
      $servicename             = 'bind9'
      $binduser                = 'bind'
      $bindgroup               = 'bind'
      $bindkeysfile            = '/etc/bind/bind.keys'
      $directory               = '/var/cache/bind'
      $dump_dir                = '/var/tmp'
      $hintsfile               = undef    # hints included in named.conf.default-zones
      $rfc1912zones            = '/etc/bind/named.conf.default-zones'
      $zonedir                 = '/etc/bind'
	  $service_restart_command = "service ${servicename} reload"
    }
    'Freebsd': {
      $packagenameprefix       = 'bind910'
      $servicename             = 'named'
      $binduser                = 'bind'
      $bindgroup               = 'bind'
      $rfc1912zones            = '/etc/named.rfc1912.zones'
      $hintsfile               = 'named.ca'
      $bindkeysfile            = '/etc/named.iscdlv.key'
      $directory               = '/var/named'
      $dump_dir                = '/var/named/data'
      $zonedir                 = '/var/named'
    }
    default: {
      $packagenameprefix       = 'bind'
      $servicename             = 'named'
      $binduser                = 'root'
      $bindgroup               = 'named'
      $rfc1912zones            = '/etc/named.rfc1912.zones'
      $hintsfile               = 'named.ca'
      $bindkeysfile            = '/etc/named.iscdlv.key'
      $directory               = '/var/named'
      $dump_dir                = '/var/named/data'
      $zonedir                 = '/var/named'
	  $service_restart_command = "service ${servicename} reload"
    }
  }

  $dump_file          = "$dump_dir/cache_dump.db"
  $statistics_file    = "$dump_dir/named_stats.txt"
  $memstatistics_file = "$dump_dir/named_mem_stats.txt"

}

