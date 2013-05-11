require 'spec_helper'

describe 'auditd', :type => :class do

  it { should create_class('auditd') }
  it { should contain_class('auditd::install') }
  it { should contain_class('auditd::config') }
  it { should contain_class('auditd::service') }

end

