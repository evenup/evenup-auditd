require 'spec_helper'

describe 'auditd' do
  let(:facts) { { :osfamily => 'RedHat' } }

  it { should contain_service('auditd').with(:ensure => 'running', :enable => true ) }

end

