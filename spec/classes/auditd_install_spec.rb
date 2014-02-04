require 'spec_helper'

describe 'auditd' do

    it { should contain_package('audit').with(:ensure => 'latest') }

end

