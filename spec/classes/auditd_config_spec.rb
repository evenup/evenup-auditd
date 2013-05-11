require 'spec_helper'

describe 'auditd::config', :type => :class do
  let(:facts) { { :concat_basedir => '/somewhere' } }

  let(:params) { {
    :logsagent  => '',
    :rules      => 'blah',
    :config     => { 'field1' => 'value1', 'field2' => 'value2' }
  } }

  it { should contain_file('/etc/audit/audit.rules').with_source('blah') }
  it { should contain_file('/etc/audit/auditd.conf').with_content(/field1\s\=\svalue1\nfield2\s\=\svalue2/) }

  describe 'with beaver' do
    let(:params) { {
      :logsagent => 'beaver',
      :rules => 'blah',
      :config => { 'log_file' => '/var/somewhere/audit.log' }
    } }

    it { should contain_beaver__stanza('/var/somewhere/audit.log') }

  end

end
