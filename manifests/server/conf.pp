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
#   Base directory for the BIND server. Defaults to os-specific path set in bind::params.
#  $rfc1912_zones:
#   BIND server zone configuration file for zones recommended by RFC 1912. Defaults to os-specific path set in bind::params.
#  $bindkeys_file:
#   Path to ISC DLV key. Defaults to os-specific path set in bind::params.
#  $hostname:
#   Hostname returned for hostname.bind TXT in CHAOS. Set to 'none' to disable.
#   Default: undef, bind internal default
#  $server_id:
#   ID returned for id.server TXT in CHAOS. Default: undef, empty
#  $version:
#   Version string override text. Default: none
#  $logging:
#   Enable logging. Default: 'yes'
#  $logfile:
#   Logfile path. Default: '/var/log/named/named.log'
#  $dump_file:
#   Dump file for the server. Default: "${bind::params::directory}/data/cache_dump.db"
#  $statistics_file:
#   Statistics file for the server. Default: "${bind::params::directory}/data/named_stats.txt"
#  $memstatistics_file:
#   Memory statistics file for the server.
#   Default: "${bind::params::directory}/data/named_mem_stats.txt"
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
#   Enable DNSSEC validation. Default: 'yes'
#  $dnssec_lookaside:
#   DNSSEC lookaside type. Default: 'auto'
#  $zones:
#   Hash of managed zones and their configuration. The key is the zone name
#   and the value is an array of config lines. Default: empty
#  $includes:
#   Array of absolute paths to named.conf include files. Default: empty
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
  $rfc1912_zones          = $::bind::params::rfc1912_zones,
  $bindkeys_file          = $::bind::params::bindkeys_file,
  $managed_keys_directory = undef,
  $hostname               = undef,
  $server_id              = undef,
  $version                = undef,
  $logging                = 'yes',
  $logfile                = '/var/log/named/named.log',
  $dump_file              = "${bind::params::directory}/data/cache_dump.db",
  $statistics_file        = "${bind::params::directory}/data/named_stats.txt",
  $memstatistics_file     = "${bind::params::directory}/data/named_mem_stats.txt",
  $allow_query            = [ 'localhost' ],
  $allow_query_cache      = [],
  $recursion              = 'yes',
  $allow_recursion        = [],
  $allow_transfer         = [],
  $check_names            = [],
  $extra_options          = {},
  $dnssec_enable          = 'yes',
  $dnssec_validation      = 'yes',
  $dnssec_lookaside       = 'auto',
  $zones                  = {},
  $includes               = [],
  $views                  = {},
) {

  # Everything is inside a single template
  file { $title:
    require => Class['bind::package'],
    notify  => Class['bind::service'],
    content => template('bind/named.conf.erb'),
  }

}

