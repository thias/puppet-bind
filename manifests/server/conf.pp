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
  $acls                   = hiera_hash('bind::server::conf::acl', {}),
  $masters                = hiera_hash('bind::server::conf::masters', {}),
  $listen_on_port         = hiera('bind::server::conf::listen_on_port', '53'),
  $listen_on_addr         = hiera_array('bind::server::conf::listen_on_addr', ['127.0.0.1']),
  $listen_on_v6_port      = hiera('bind::server::conf::listen_on_v6_port', '53'),
  $listen_on_v6_addr      = hiera_array('bind::server::conf::listen_on_v6_addr', ['::1']),
  $forwarders             = hiera_array('bind::server::conf::forwarders', []),
  $directory              = hiera('bind::server::conf::directory', '/var/named'),
  $managed_keys_directory = hiera('bind::server::conf::managed_keys_directory', false),
  $hostname               = hiera('bind::server::conf::hostname', false),
  $server_id              = hiera('bind::server::conf::server_id', false),
  $version                = hiera('bind::server::conf::version', false),
  $dump_file              = hiera('bind::server::conf::dump_file', '/var/named/data/cache_dump.db'),
  $statistics_file        = hiera('bind::server::conf::statistics_file', '/var/named/data/named_stats.txt'),
  $memstatistics_file     = hiera('bind::server::conf::memstatistics_file', '/var/named/data/named_mem_stats.txt'),
  $allow_query            = hiera_array('bind::server::conf::allow_query', ['localhost']),
  $allow_query_cache      = hiera_array('bind::server::conf::allow_query_cache', []),
  $recursion              = hiera('bind::server::conf::recursion', 'yes'),
  $allow_recursion        = hiera_array('bind::server::conf::allow_recursion', []),
  $allow_transfer         = hiera_array('bind::server::conf::allow_transfer', []),
  $check_names            = hiera_array('bind::server::conf::check_names', []),
  $extra_options          = hiera_hash('bind::server::conf::extra_options', {}),
  $dnssec_enable          = hiera('bind::server::conf::dnssec_enable', 'yes'),
  $dnssec_validation      = hiera('bind::server::conf::dnssec_validation', 'yes'),
  $dnssec_lookaside       = hiera('bind::server::conf::dnssec_lookaside', 'auto'),
  $zones                  = hiera_hash('bind::server::conf::zones', {}),
  $includes               = hiera_array('bind::server::conf::includes', []),
  $views                  = hiera_hash('bind::server::conf::views', {}),
  $main_log               = hiera('bind::server::conf::main_log', '/var/log/named/named.log'),
  $rndc_keys              = hiera_hash('bind::server::conf::rndc_keys', {}),
  $controls               = hiera_array('bind::server::conf::controls', []),
) {

  # Everything is inside a single template
  file { $title :
    notify  => Class['bind::service'],
    content => template('bind/named.conf.erb'),
  }

}
