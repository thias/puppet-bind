class bind::package {
  package { $bind::packagename : 
    ensure => installed 
  }
}