# -- Class: auditd::params
#
# Default parameters for the auditd module
#
class auditd::params {

  $logsagent = undef
  $rules = 'puppet:///modules/auditd/audit.rules'

  case $::osfamily {
    'Debian': {
      $package_name = 'auditd'
      $audit_rules_file = '/etc/audit/audit.rules'
      $restart_cmd = '/etc/init.d/auditd restart'

      case $::lsbmajdistrelease {
        '10.04': {
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
            'tcp_client_max_idle'     => 0,
            'enable_krb5'             => 'no',
            'krb5_principal'          => 'auditd'
          }
        }
        default: {
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
        }
      }

    }
    'RedHat': {
      $package_name = 'audit'
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

      # RHEL7 moved audit rules to rules.d and breaks restart
      # https://bugzilla.redhat.com/show_bug.cgi?id=973697
      if versioncmp($::operatingsystemrelease, '6') > 0 {
        $audit_rules_file = '/etc/audit/rules.d/audit.rules'
        $restart_cmd = '/sbin/service auditd restart'
      } else {
        $audit_rules_file = '/etc/audit/audit.rules'
        $restart_cmd = '/etc/init.d/auditd restart'
      }
    }
    default: {
      fail("${::osfamily} is not supported by auditd")
    }
  }

}
