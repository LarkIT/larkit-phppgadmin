# == Class phppgadmin::config
#
# This class is called from phppgadmin for service config.
#
class phppgadmin::config (
  $config      = $::phppgadmin::real_config,
  $servers     = $::phppgadmin::servers,
){

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { $::phppgadmin::config_file:
    ensure  => file,
    mode    => '0440',
    owner   => $::phppgadmin::www_user,
    group   => $::phppgadmin::www_group,
    content => template("${module_name}/config.inc.php.erb"),
  }

}
