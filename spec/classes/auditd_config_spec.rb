require 'spec_helper'

describe 'auditd' do
  context 'RedHat' do
    context '6' do
      let(:facts) { { :concat_basedir => '/somewhere', :osfamily => 'RedHat', :disposition => 'prod', :operatingsystemrelease => '6' } }
      let(:params) { {
        :logsagent        => '',
        :rules            => 'blah',
        :config_override  => { 'field1' => 'value1', 'field2' => 'value2' }
      } }

      it { should contain_file('/etc/audit/audit.rules').with_source('blah') }
      it { should contain_file('/etc/audit/auditd.conf').with_content(/field1\s\=\svalue1\nfield2\s\=\svalue2/) }
    end

    context '7' do
      let(:facts) { { :concat_basedir => '/somewhere', :osfamily => 'RedHat', :disposition => 'prod', :operatingsystemrelease => '7' } }
      let(:params) { {
        :logsagent        => '',
        :rules            => 'blah',
        :config_override  => { 'field1' => 'value1', 'field2' => 'value2' }
      } }

      it { should contain_file('/etc/audit/rules.d/audit.rules').with_source('blah') }
      it { should contain_file('/etc/audit/auditd.conf').with_content(/field1\s\=\svalue1\nfield2\s\=\svalue2/) }
    end
  end

  context 'Ubuntu' do
    let(:facts) { { :concat_basedir => '/somewhere', :osfamily => 'Debian', :disposition => 'prod', :lsbmajdistrelease => '14.04' } }
    let(:params) { {
      :logsagent        => '',
      :rules            => 'blah',
      :config_override  => { 'field1' => 'value1', 'field2' => 'value2' }
    } }

    it { should contain_file('/etc/audit/audit.rules').with_source('blah') }
    it { should contain_file('/etc/audit/auditd.conf').with_content(/field1\s\=\svalue1\nfield2\s\=\svalue2/) }

  end


  describe 'with beaver' do
    let(:facts) { { :concat_basedir => '/somewhere', :osfamily => 'RedHat', :operatingsystemrelease => '7', :disposition => 'prod' } }
    let(:params) { {
      :logsagent        => 'beaver',
      :rules            => 'blah',
      :config_override  => { 'log_file' => '/var/somewhere/audit.log' }
    } }

    it { should contain_beaver__stanza('/var/somewhere/audit.log') }
  end

end
