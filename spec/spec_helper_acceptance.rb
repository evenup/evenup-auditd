require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    install_puppet
  end

  hosts.each do |host|
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # Install module and dependencies
      if fact('osfamily') == 'Debian' and (fact('operatingsystemmajrelease') == '12.04' or fact('operatingsystemmajrelease') == '10.04')
        # RubyGems missing on some Ubuntu 12 boxes
        # Otherwise you'lll get a load of 'Provider gem is not functional on this host'
        shell('apt-get install rubygems -y')
      end


      copy_module_to(host, :source => proj_root, :module_name => 'auditd')

      on host, puppet('module', 'install', 'evenup/beaver'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs/concat'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs/stdlib'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
