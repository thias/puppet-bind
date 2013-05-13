# puppet-bind

## Overview

Install and enable a BIND DNS server, manage its main configuration and install
and manage its DNS zone files.

* `bind` : Main class to install and enable the server.
* `bind::server::conf` : Main definition to configure the server.
* `bind::server::file` : Definition to manage zone files.
* `bind::package` : Class to install the server package (included from `bind`)
* `bind::service` : Class to manage the server service (included from `bind`)

The split between `bind` and `bind::server::conf` allows to use a static file
or a different template-based file for the main `named.conf` file if needed,
while still using this module for the main package, service and managing zone
files. This is useful if you have a large and/or complex named.conf file.
Note that you may also use the `bind::package` and `bind::service` classes on
their own, though you won't need to if you use the main class, which includes
them both.

## Examples

Here is a typical LAN recursive caching DNS server configuration :

    include bind
    bind::server::conf { '/etc/named.conf':
      listen_on_addr    => [ 'any' ],
      listen_on_v6_addr => [ 'any' ],
      forwarders        => [ '8.8.8.8', '8.8.4.4' ],
      allow_query       => [ 'localnets' ],
      zones             => {
        'myzone.lan' => [
          'type master',
          'file "myzone.lan"',
        ],
        '1.168.192.in-addr.arpa' => [
          'type master',
          'file "1.168.192.in-addr.arpa"',
        ],
      },
    }

The zone files for the above could then be managed like this :

    bind::server::file { 'myzone.lan':
      source => 'puppet:///modules/mymodule/dns/myzone.lan',
    }
    bind::server::file { '1.168.192.in-addr.arpa':
      source => 'puppet:///modules/mymodule/dns/1.168.192.in-addr.arpa',
    }

Then if all source files are in the same location and named after the zone :

    bind::server::file { [ 'myzone.lan', '1.168.192.in-addr.arpa' ]:
      source_base => 'puppet:///modules/mymodule/dns/',
    }

Data can also be put in Hiera, like so:

    classes:
      - 'bind'
    bind::named_conf:
      /etc/named.conf:
        listen_on_addr:    - 'any'
        listen_on_v6_addr: - 'any'
        forwarders:
          - '8.8.8.8'
          - '8.8.4.4'
        allow_query: - 'localnets'
        zones:
          myzone.lan:
            - 'type master'
            - 'file "myzone.lan"'
          1.168.192.in-addr.arpa:
            - 'type master'
            - 'file "1.168.192.in-addr.arpa"'
    bind::zone_files:
      myzone.lan:
        source: 'puppet:///modules/mymodule/dns/myzone.lan'
      1.168.192.in-addr.arpa:
        source: 'puppet:///modules/mymodule/dns/1.168.192.in-addr.arpa'

For RHEL5, you might want to use the newest possible bind packages :

    class { 'bind': packagenameprefix => 'bind97' }

Or in Hiera:
    classes:
      - 'bind'
    bind:
      packagenameprefix: 'bind97'

Since SELinux offers a very high level of protection, chrooting is quite
redundant, so it's disabled by default. You can nevertheless enable it if
you want :

    class { 'bind': chroot => true }
    bind::server::conf { '/etc/named.conf':
      # [... same as before ...]
    },
    bind::server::file { 'myzone.lan':
      directory => '/var/named/chroot/var/named',
      source  => 'puppet:///files/dns/myzone.lan',
    }

To avoid repeating the `directory` parameter each time, you can also use :

    Bind::Server::File { directory => '/var/named/chroot/var/named' }

