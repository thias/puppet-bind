# Define: bind::server::conf
#
# ISC BIND server template-based configuration definition.
#
# Parameters:
#  $acls:
#   Hash of client ACLs, name as key and array of config lines. Default: empty
#  $masters:
#   Hash of master ACLs, name as key and array of config lines. Default: empty
#  $listen_on_port:
#   IPv4 port to listen on. Set to false to disable. Default: '53'
#  $listen_on_addr:
#   Array of IPv4 addresses to listen on. Default: [ '127.0.0.1' ]
#  $listen_on_v6_port:
#   IPv6 port to listen on. Set to false to disable. Default: '53'
#  $listen_on_v6_addr:
#   Array of IPv6 addresses to listen on. Default: [ '::1' ]
#  $forwarders:
#   Array of forwarders IP addresses. Default: empty
#  $directory:
#   Base directory for the BIND server. Default: '/var/named'
#  $hostname:
#   Hostname returned for hostname.bind TXT in CHAOS. Set to 'none' to disable.
#   Default: undef, bind internal default
#  $server_id:
#   ID returned for id.server TXT in CHAOS. Default: undef, empty
#  $version:
#   Version string override text. Default: none
#  $dump_file:
#   Dump file for the server. Default: '/var/named/data/cache_dump.db'
#  $statistics_file:
#   Statistics file for the server. Default: '/var/named/data/named_stats.txt'
#  $memstatistics_file:
#   Memory statistics file for the server.
#   Default: '/var/named/data/named_mem_stats.txt'
#  $allow_query:
#   Array of IP addrs or ACLs to allow queries from. Default: [ 'localhost' ]
#  $recursion:
#   Allow recursive queries. Default: 'yes'
#  $allow_recursion:
#   Array of IP addrs or ACLs to allow recursion from. Default: empty
#  $allow_transfer:
#   Array of IP addrs or ACLs to allow transfer to. Default: empty
#  $check_names:
#   Array of check-names strings. Example: [ 'master ignore' ]. Default: empty
#  $extra_options:
#   Hash for any additional options that must go in the 'options' declaration. Default: empty
#  $dnssec_enable:
#   Enable DNSSEC support. Default: 'yes'
#  $dnssec_validation:
#   Enable DNSSEC validation. Default: 'auto'
#  $dnssec_lookaside:
#   DNSSEC lookaside type. Default: empty
#  $bindkeys_file:
#   The pathname of a file to override the built-in trusted keys provided by named
#  $hostname
#   The host-name (a quotes string) the server should report via a query of the
#   name hostname.bind with type TXT, class CHAOS.  Specifying none disables.
#   Defaut: None
#  $server_id
#   The ID the server will return via a query for ID.SERVER with type TXT,
#   under class CH (CHAOS). Default: empty
#  $zones:
#   Hash of managed zones and their configuration. The key is the zone name
#   and the value is an array of config lines. Default: empty
#  $includes:
#   Array of absolute paths to named.conf include files. Default: empty
#   on Debian systems,  consider adding the 1918 zones here, if they are not used in your
#   organisation. (/etc/bind/zones.rfc1918)
#  $keyss:
#   Hash of managed dns keys for update
#   and the value is an array of config lines. Default: empty
#
# Sample Usage :
#  bind::server::conf { '/etc/named.conf':
#    acls => {
#      'rfc1918' => [ '10/8', '172.16/12', '192.168/16' ],
#    },
#    masters => {
#      'mymasters' => [ '192.0.2.1', '198.51.100.1' ],
#    },
#    zones => {
#      'example' => [
#        'algorithm HMAC-MD5.SIG-ALG.REG.INT',
#        'secret "asdasddsaasd/dsa=="',
#      ],
#      'example.org' => [
#        'type slave',
#        'file "slaves/example.org"',
#        'masters { mymasters; }',
#      ],
#    }
#    zones => {
#      'example.com' => [
#        'type master',
#        'file "example.com"',
#      ],
#      'example.org' => [
#        'type slave',
#        'file "slaves/example.org"',
#        'masters { mymasters; }',
#      ],
#    }
#  }
#
define bind::server::conf (
  $acls                   = {},
  $masters                = {},
  $listen_on_port         = '53',
  $listen_on_addr         = [ '127.0.0.1' ],
  $listen_on_v6_port      = '53',
  $listen_on_v6_addr      = [ '::1' ],
  $forwarders             = [],
  $directory              = $::bind::params::directory,
  $managed_keys_directory = undef,
  $hostname               = undef,
  $server_id              = undef,
  $version                = undef,
  $dump_file              = $::bind::params::dump_file,
  $statistics_file        = $::bind::params::statistics_file,
  $memstatistics_file     = $::bind::params::memstatistics_file,
  $allow_query            = [ 'localhost' ],
  $allow_query_cache      = [],
  $recursion              = 'yes',
  $allow_recursion        = [],
  $allow_transfer         = [],
  $check_names            = [],
  $extra_options          = {},
  $dnssec_enable          = 'yes',
  $dnssec_validation      = 'auto',
  $dnssec_lookaside       = undef,
  $bindkeys_file          = undef,
  $hostname               = 'none',
  $server_id              = undef,
  $zones                  = {},
  $keys                   = {},
  $includes               = [],
  $views                  = {},
) {
  
  # set distribution specific variables that are used in the template
  $hintsfile = $::bind::params::hintsfile
  $rfc1912zones = $::bind::params::rfc1912zones
  $bindkeysfile = $::bind::params::bindkeysfile

  # Everything is inside a single template
  file { $directory:
      ensure => directory,
  }
  file { $title:
    notify  => Class['bind::service'],
    content => template('bind/named.conf.erb'),
    require => Class['bind::package'],
  }
  #set the Debian system apparmor to inclus the working directory
  case $::osfamily {
    'Debian': {
      file { '/etc/apparmor.d/usr.sbin.named':
        ensure =>   present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('bind/usr.sbin.named.erb'),
        notify  => Exec['refresh_apparmor'];
      }
      exec { 'refresh_apparmor':
        command => '/usr/sbin/invoke-rc.d apparmor reload',
        refreshonly => true;
      }
    }
  }
}
