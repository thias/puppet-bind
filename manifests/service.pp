# Class: bind::service
#
class bind::service (
  $servicename             = $::bind::params::servicename,
  $service_reload          = true,
  $service_restart_command = $::bind::params::service_restart_command,
) inherits ::bind::params {

  if $service_reload {
    Service[$servicename] {
      restart => $service_restart_command,
    }
  }

  service { $servicename :
    require   => Class['bind::package'],
    hasstatus => true,
    enable    => true,
    ensure    => running,
  }
  
}
