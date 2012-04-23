# Define: bind::server::file
#
# ISC BIND server template-based or pre-created zone file definition.
# Either of $source or $content must be specificed when using it.
#
# Parameters:
#  $zonedir:
#    Directory where to store the zone file. Default: '/var/named'
#  $owner:
#    Zone file user owner. Default: 'root'
#  $group:
#    Zone file group owner. Default: 'named'
#  $mode:
#    Zone file mode: Default: '0640'
#  $source:
#    Zone file content source. Default: none
#  $content:
#    Zone file content (usually template-based). Default: none
#
# Sample Usage :
#  bind::server::file { 'example.com':
#      zonedir => '/var/named/chroot/var/named',
#      source  => 'puppet:///files/dns/example.com',
#  }
#
define bind::server::file (
    $zonedir = '/var/named',
    $owner   = 'root',
    $group   = 'named',
    $mode    = '0640',
    $source  = undef,
    $content = undef
) {

    file { "${zonedir}/${title}":
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        source  => $source,
        content => $content,
        notify  => Service['named'],
    }

}

