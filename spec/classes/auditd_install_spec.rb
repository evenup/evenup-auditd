require 'spec_helper'

describe 'auditd::install', :type => :class do

    it { should contain_package('audit').with(:ensure => 'latest') }

end

