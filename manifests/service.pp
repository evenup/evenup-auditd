# == Class: auditd::service
#
# This class manges the auditd service.  It is not intended to be called
# directly.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class auditd::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'auditd':
    ensure  => 'running',
    enable  => true,
  }

}
