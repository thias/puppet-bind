# Class: bind::service
#
class bind::service (
  $servicename    = $::bind::params::servicename,
  $service_reload = true,
) inherits ::bind::params {

  if $service_reload {
    Service[$servicename] {
      restart => "service ${servicename} reload",
    }
  }

  service { $servicename :
    require   => Class['bind::package'],
    hasstatus => true,
    enable    => true,
    ensure    => running,
  }
  
}
