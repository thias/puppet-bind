class bind::service {
  service { $bind::servicename :
    require   => Class[bind::package],
    hasstatus => true,
    enable    => true,
    ensure    => running,
    path      => $::path
    restart   => "service ${bind::servicename} reload",
  }
}