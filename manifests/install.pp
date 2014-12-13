# == Class: auditd::install
#
# This class installs auditd.  It is not intended to be called directly.
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
class auditd::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'audit':
    ensure => 'latest',
    name   => $auditd::package_name,
    notify => Class['auditd::service'],
  }

}
