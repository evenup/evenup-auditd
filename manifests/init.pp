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
  $audit_rules_file = $::auditd::params::audit_rules_file,
  $logsagent        = $::auditd::params::logsagent,
  $rules            = $::auditd::params::rules,
  $package_name     = $::auditd::params::package_name,
  $restart_cmd      = $::auditd::params::restart_cmd,
  $config_override  = {},
) inherits auditd::params {

  # Apply config overrides to the default config
  if !is_hash($config_override) {
    fail('config_override in auditd needs to be a hash')
  }

  $config = merge($auditd::params::default_config, $config_override)

  anchor { 'auditd::begin': } ->
  class { 'auditd::install': } ->
  class { 'auditd::config': } ~>
  class { 'auditd::service': } ->
  anchor { 'auditd::end': }

}
