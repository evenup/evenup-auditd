require 'spec_helper'

describe 'auditd' do

  it { should contain_service('auditd').with(:ensure => 'running', :enable => true ) }

end

