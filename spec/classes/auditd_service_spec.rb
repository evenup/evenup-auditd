require 'spec_helper'

describe 'auditd' do
  context 'default' do
    let(:facts) { { :osfamily => 'RedHat', :operatingsystemrelease => '6' } }

    it { should contain_service('auditd').with(:ensure => 'running', :enable => true, :restart => '/etc/init.d/auditd restart' ) }
  end

  context 'RedHat 7' do
    let(:facts) { { :osfamily => 'RedHat', :operatingsystemrelease => '7' } }
    it { should contain_service('auditd').with(:ensure => 'running', :enable => true, :restart => '/sbin/service auditd restart' ) }
  end
end

