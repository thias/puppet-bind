# == Define: bind::zone::record
# Creates a resource record in DNS zone file
define bind::zone::record (
  $target_file,
  $rname,
  $rdata,
  $rtype  = 'A',
  $rclass = 'IN',
  $order  = '99',
){
  $record_data = $rtype ? {
      /(NS|CNAME|PTR)/ => "${rdata}.",
      default          => $rdata,
  }

  concat::fragment { "${target_file}_${name}":
    target  => $target_file,
    content => "${rname}\t${rclass}\t${rtype}\t${record_data}\n",
    order   => $order,
  }
}
