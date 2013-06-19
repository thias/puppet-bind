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
#  $version:
#   Version string override text. Default: none
#  $dump_file:
#   Dump file for the server. Default: '/var/named/data/cache_dump'
#  $statistics_file:
#   Statistics file for the server. Default: '/var/named/data/named_stats'
#  $memstatistics_file:
#   Memory statistics file for the server.
#   Default: '/var/named/data/named_mem_stats'
#  $allow_query:
#   Array of IP addrs or ACLs to allow queries from. Default: [ 'localhost' ]
#  $recursion:
#   Allow recursive queries. Default: 'yes'
#  $allow_recursion:
#   Array of IP addrs or ACLs to allow recursion from. Default: empty
#  $allow_transfer:
#   Array of IP addrs or ACLs to allow transfer to. Default: empty
#  $dnssec_enable:
#   Enable DNSSEC support. Default: 'yes'
#  $dnssec_validation:
#   Enable DNSSEC validation. Default: 'auto' (Bind 9.7+ only)
#  $dnssec_lookaside:
#   DNSSEC lookaside type. Default: 'auto' (Bind 9.7+ only)
#   Manually specify a DLV key file to silence warnings.
#   [ https://www.isc.org/downloads/bind/dlv/ ]
#  $zones:
#   Hash of managed zones and their configuration. The key is the zone name
#   and the value is an array of config lines. Default: empty
#  $includes:
#   Array of absolute paths to named.conf include files. Default: empty
#   Use this to reference files that are managed by other modules or
#   as bind::server::file resources.
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
# Sample Usage with Hiera (resource created in main bind class)
# ---
# bind::server_conf:
#   /etc/named.conf:
#     acls:
#       rfc1918:
#         - '10/8'
#         - '172.16/12'
#         - '192.168/16'
#     masters:
#       mymasters:
#         - '192.0.2.1'
#         - '198.51.100.1'
#     zones:
#       example.com:
#         - 'type master'
#         - 'file "example.com"'
#       example.org:
#         - 'type slave',
#         - 'file "slaves/example.org"'
#         - 'masters { mymasters; }'
#     includes:
#       - '/etc/named/named_extra.conf'
#
# bind::server_files:
#   named_extra.conf:
#     directory: '/etc/named'
#     source:    'puppet:///modules/bind/named_extra.conf'
#
define bind::server::conf (
  $owner              = undef,
  $group              = undef,
  $mode               = '0644',
  $acls               = {},
  $masters            = {},
  $listen_on_port     = '53',
  $listen_on_addr     = [ '127.0.0.1' ],
  $listen_on_v6_port  = '53',
  $listen_on_v6_addr  = [ '::1' ],
  $forwarders         = [],
  $directory          = '/var/named',
  $version            = undef,
  $empty_zones_enable = undef,
  $zone_statistics    = 'no',
  $stats_directory    = '/var/named/data',
  $dump_file          = 'cache_dump',
  $statistics_file    = 'named_stats',
  $memstatistics_file = 'named_mem_stats',
  $allow_query        = [ 'localhost' ],
  $allow_query_cache  = [],
  $recursion          = 'yes',
  $allow_recursion    = [],
  $allow_transfer     = [],
  $transfers_in       = '10',
  $transfers_out      = '10',
  $dnssec_enable      = 'yes',
  $dnssec_validation  = undef,
  $dnssec_lookaside   = undef,
  $zones              = {},
  $includes           = []
) {
  include bind::params

  # Honor defaults for the bind class
  if $owner { $fowner = $owner } else { $fowner = $bind::params::binduser }
  if $group { $fgroup = $group } else { $fgroup = $bind::params::bindgroup }

  # Configuration options, at least, are inside a template
  file { $title:
    owner   => $fowner,
    group   => $fgroup,
    mode    => $mode,
    notify  => Class['bind::service'],
    content => template('bind/named.conf.erb'),
  }

}

