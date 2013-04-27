#for backwards compatibility.
class bind::server (
  $chroot = false,
  # For RHEL5 you might want to use 'bind97'
  $bindpkgprefix = 'bind'
){
	class { 'bind':
		chroot => $chroot,
		bindpkgprefix => $bindpkgprefix
	}
	
}