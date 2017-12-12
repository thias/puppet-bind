# == Define: bind::zone::record
# Creates a resource record in DNS zone file
#
# Parameters:
#  $target_file:
#   full name of the zone file,
#  $rname:
#   name of person or role account dealing with this zone, can be alias,
#  $rdata:
#   ip or name of server-record,
#  $rtype:
#   type of dns record, default: A,
#  $rclass
#   zone class, default: IN,
#  $order:
#   oreder of concat fragment, default: 99,
#  $path:
#   path to assert command, default: /sbin,

define bind::zone::record (
  $target_file,
  $rname,
  $rdata,
  $rtype  = 'A',
  $rclass = 'IN',
  $order  = '99',
  $path   = '/sbin/'
){
  include ::bind

  $record_data = $rtype ? {
      /(NS|CNAME|PTR)/ => "${rdata}.",
      default          => $rdata,
  }

  concat::fragment { "${target_file}_${name}":
    target  => $target_file,
    content => "${rname}\t${rclass}\t${rtype}\t${record_data}\n",
    order   => $order,
  }
  assert { "Check zone file-${target_file}":
    command => "${path}named-checkzone ${name} ${target_file}",
    require => [
      File[$target_file],
      Concat::Fragment["${target_file}_${name}"]
      ],
    before  => Class['::bind::service']
  }
}
