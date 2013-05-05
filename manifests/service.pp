# Class: bind::service
#
class bind::service (
  $servicename = $bind::params::servicename
) inherits bind::params {

  service { $servicename :
    require   => Class['bind::package'],
    hasstatus => true,
    enable    => true,
    ensure    => running,
    restart   => "service ${servicename} reload"
  }

}
