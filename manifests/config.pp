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
class auditd::config (
  $logsagent,
  $rules,
  $config,
){

  file { '/etc/audit/audit.rules':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    source  => $rules,
    notify  => Class['auditd::service'],
  }

  file { '/etc/audit/auditd.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => template('auditd/auditd.conf.erb'),
    notify  => Class['auditd::service'],
  }

  case $logsagent {
    'beaver': {
      beaver::stanza { $config['log_file']:
        type  => 'auditlog',
        tags  => [ 'audit', $::disposition ],
      }
    }
    default: {}
  }

}
