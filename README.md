What is it?
===========

A Puppet module that ensures the linux audit packages are installed and
configured.  It has a basic set of rules provided, but can be overridden
with rules you provide.

Released under the Apache 2.0 licence

Usage:
------

To install:
<pre>
  class { 'auditd': }
</pre>

To override a setting in the default config
<pre>
  class { 'auditd':
    config_override => { 'num_logs' => 6 }
  }
</pre>


Contribute:
-----------
* Fork it
* Create a topic branch
* Improve/fix (with spec tests)
* Push new topic branch
* Submit a PR
