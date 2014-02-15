# -- Class: auditd::params
#
# Default parameters for the auditd module
#
class auditd::params {
  case $::osfamily {
    'Debian': { $package_name = 'auditd' }
    default: { $package_name = 'audit' }
  }
}
