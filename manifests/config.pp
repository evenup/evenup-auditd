# == Class: auditd::config
#
# This class configures auditd.  It is not intended to be called directly.
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
class auditd::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { $::auditd::audit_rules_file:
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
    source => $::auditd::rules,
    notify => Class['auditd::service'],
  }

  file { '/etc/audit/auditd.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => template('auditd/auditd.conf.erb'),
    notify  => Class['auditd::service'],
  }

  case $::auditd::logsagent {
    'beaver': {
      beaver::stanza { $::auditd::config['log_file']:
        type => 'auditlog',
        tags => [ 'audit', $::disposition ],
      }
    }
    default: {}
  }

}
