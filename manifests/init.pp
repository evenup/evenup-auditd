# == Class: auditd
#
# This class installs and configures auditd
#
#
# === Parameters
#
# [*logsagent*]
#   String.  What agent should process the logfile.
#   Valid options: beaver, ''
#   Default: ''
#
# [*rules*]
#   String.  Source of rules file to apply
#   Default: puppet:///modules/auditd/audit.rules
#
# [*config_overrides*]
#   Hash.  Hash containing overrides for the defalut values (below)
#   Default: {}
#
#
# === Examples
#
# * Installation:
#     class { 'auditd': }
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
class auditd (
  $logsagent        = '',
  $rules            = 'puppet:///modules/auditd/audit.rules',
  $config_override  = {},
  $package_name     = $auditd::params::package_name,
) inherits auditd::params {

  # Apply config overrides to the default config
  $default_config = {
    'log_file'                => '/var/log/audit/audit.log',
    'log_format'              => 'RAW',
    'log_group'               => 'root',
    'priority_boost'          => 4,
    'flush'                   => 'INCREMENTAL',
    'freq'                    => 20,
    'num_logs'                => 5,
    'disp_qos'                => 'lossy',
    'dispatcher'              => '/sbin/audispd',
    'name_format'             => 'NONE',
    'max_log_file'            => 6,
    'max_log_file_action'     => 'ROTATE',
    'space_left'              => 75,
    'space_left_action'       => 'SYSLOG',
    'action_mail_acct'        => 'root',
    'admin_space_left'        => 50,
    'admin_space_left_action' => 'SUSPEND',
    'disk_full_action'        => 'SUSPEND',
    'disk_error_action'       => 'SUSPEND',
    'tcp_listen_queue'        => 5,
    'tcp_max_per_addr'        => 1,
    'tcp_client_max_idle'     => 0,
    'enable_krb5'             => 'no',
    'krb5_principal'          => 'auditd'
  }

  $config = merge($default_config, $config_override)


  # Take care of business
  class { 'auditd::install': }

  class { 'auditd::config': }

  class { 'auditd::service': }

  # Containment
  anchor { 'auditd::begin': }
  anchor { 'auditd::end': }

  Anchor['auditd::begin'] ->
  Class['auditd::install'] ->
  Class['auditd::config'] ->
  Class['auditd::service'] ->
  Anchor['auditd::end']

}
