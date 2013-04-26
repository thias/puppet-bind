class bind::service {
  service { $bind::servicename :
    require   => Class[bind::package],
    hasstatus => true,
    enable    => true,
    ensure    => running,
    restart   => "/sbin/service ${bind::servicename} reload",
  }
}