# Class: phppgadmin
# ===========================
#
# Puppet module to manage phpPgAdmin.  phpPgAdmin is a web-based administration tool for PostgreSQL.
#
# Parameters
# ----------
#
# [*config*]
#   Configuration parameters to apply to phpmyadmin
#   Hashs.  Default {}
#
# [*servers*]
#   Servers to add to the Configuration
#   Array of Hashes.  Default {}

# [*srv_groups*]
#   PostgreSQL server groups
#   Array of Hashes.  Default {}
#
# [*config_file*]
#   Configuration file for phpPgAdmin
#   String.
#
# [*package_name*]
#   Name of the phpPgAdmin package
#
# [*www_user*]
#   User name the config file should be owend by.  This will typically be your web server
#
# [*www_group*]
#   Group the config file should be owend by.  This will typically be your web server
#
# [*version*]
#   String.  Version of phpPgAdmin to install
#   Default: present
#
class phppgadmin (
  $config         = {},
  $servers        = [],
  $srv_groups     = [],
  $config_file    = $::phppgadmin::params::config_file,
  $package_name   = $::phppgadmin::params::package_name,
  $www_user       = $::phppgadmin::params::www_user,
  $www_group      = $::phppgadmin::params::www_group,
  $version        = $::phppgadmin::params::version,
) inherits ::phppgadmin::params {

  if !is_hash($config) {
    fail('::phppgadmin::config must be a hash')
  }

  if !is_array($servers) {
    fail('::phppgadmin::servers must be an array of hashes')
  }

  if !is_array($srv_groups) {
    fail('::phppgadmin::srv_groups must be an array of hashes')
  }

  validate_absolute_path($config_file)

  $real_config = merge($::phppgadmin::params::default_config, $config)

  class { '::phppgadmin::install': } ->
  class { '::phppgadmin::config': } ->
  Class['::phppgadmin']
}
