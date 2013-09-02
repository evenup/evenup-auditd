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

  service { 'auditd':
    ensure  => 'running',
    enable  => true,
  }

}
