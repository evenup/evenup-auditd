require 'spec_helper'

describe 'auditd::service', :type => :class do

  it { should contain_service('auditd').with(:ensure => 'running', :enable => true ) }

end

