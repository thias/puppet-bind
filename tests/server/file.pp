bind::server::file { "example.com":
    source => "puppet:///files/dns/rpmfusion.net",
    source => "puppet:///modules/bind/named.empty",
}
