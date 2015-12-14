# == Class phppgadmin::install
#
# This class is called from phppgadmin for install.
#
class phppgadmin::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  package { $::phppgadmin::package_name:
    ensure => $::phppgadmin::version,
  }
}
