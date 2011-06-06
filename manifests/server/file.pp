# ISC BIND server template-based zone file definition.
#
# Sample Usage :
#    bind::server::file { "example.com":
#        zonedir => "/var/named/chroot/var/named",
#        source  => "puppet:///files/dns/example.com",
#    }
#
define bind::server::file (
    $zonedir = "/var/named",
    $owner = "root",
    $group = "named",
    $mode = 0640,
    $source
) {

    file { "${zonedir}/${title}":
        owner  => $owner,
        group  => $group,
        mode   => $mode,
        source => $source,
        notify => Service["named"],
    }

}

