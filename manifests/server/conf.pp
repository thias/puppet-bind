# ISC BIND server template-based configuration definition.
#
# Sample Usage :
#    bind::server::conf { '/etc/named.conf':
#        acls => {
#            'rfc1918' => [ '10/8', '172.16/12', '192.168/16' ],
#        },
#        masters => {
#            'mymasters' => [ '192.0.2.1', '198.51.100.1' ],
#        },
#        zones => {
#            'example.com' => [
#                'type master',
#                'file "example.com"',
#            ],
#            'example.org' => [
#                'type slave',
#                'file "slaves/example.org"',
#                'masters { mymasters; }',
#            ],
#        }
#    }
#
define bind::server::conf (
    $acls = false,
    $masters = false,
    $listen_on_port = '53',
    $listen_on_addr = [ '127.0.0.1' ],
    $listen_on_v6_port = '53',
    $listen_on_v6_addr = [ '::1' ],
    $forwarders = [],
    $directory = '/var/named',
    $version = false,
    $dump_file = '/var/named/data/cache_dump.db',
    $statistics_file = '/var/named/data/named_stats.txt',
    $memstatistics_file = '/var/named/data/named_mem_stats.txt',
    $allow_query = [ 'localhost' ],
    $recursion = 'yes',
    $dnssec_enable = 'yes',
    $dnssec_validation = 'yes',
    $dnssec_lookaside = 'auto',
    $zones = false
) {

    file { $title:
        notify => Service['named'],
        content => template('bind/named.conf.erb'),
    }

}

