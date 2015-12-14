# == Class phppgadmin::params
#
# This class is meant to be called from phppgadmin.
# It sets variables according to platform.
#
class phppgadmin::params {

  $default_config = {}
  $version = 'present'

  case $::osfamily {
    'RedHat', 'Amazon': {
      $package_name = 'phpPgAdmin'
      $config_file  = '/etc/phpPgAdmin/config.inc.php'
      $www_user     = 'apache'
      $www_group    = 'apache'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
