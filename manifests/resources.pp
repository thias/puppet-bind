# Load dynamic resources from Hiera
class bind::resources (
  $server_conf       = [],
  $server_files      = []
) {
  create_resources(bind::server::conf,$server_conf)
  create_resources(bind::server::file,$server_files)
}
