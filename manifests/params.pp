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
      $directory         = '/var/named'
      $dump_dir          = '/var/named/data'
    }
    'Debian': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $file_hint         = undef # hints are loaded in named.conf.default-zones
      $file_rfc1912      = '/etc/bind/named.conf.default-zones'
      $file_bindkeys     = '/etc/bind/bind.keys'
      $directory         = '/var/cache/bind'
      $dump_dir          = '/var/tmp'
    }
    'Freebsd': {
      $packagenameprefix = 'bind910'
      $servicename       = 'named'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $file_hint         = 'named.ca'
      $file_rfc1912      = '/etc/named.rfc1912.zones'
      $file_bindkeys     = '/etc/named.iscdlv.key'
      $directory         = '/var/named'
      $dump_dir          = '/var/named/data'
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $file_hint         = 'named.ca'
      $file_rfc1912      = '/etc/named.rfc1912.zones'
      $file_bindkeys     = '/etc/named.iscdlv.key'
      $directory         = '/var/named'
      $dump_dir          = '/var/named/data'
    }
  }

  $dump_file          = "$dump_dir/cache_dump.db"
  $statistics_file    = "$dump_dir/named_stats.txt"
  $memstatistics_file = "$dump_dir/named_mem_stats.txt"

}

