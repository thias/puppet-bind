# Class: bind::server
#
# For backwards compatibility. Use the main bind class instead.
#
class bind::server (
  $chroot        = false,
  $bindpkgprefix = 'bind'
){
  class { 'bind':
    chroot        => $chroot,
    bindpkgprefix => $bindpkgprefix,
  }
}

