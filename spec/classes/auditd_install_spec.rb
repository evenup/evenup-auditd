require 'spec_helper'

describe 'auditd' do

    it { should contain_package('audit').with_name('audit').with_ensure('latest') }

    context 'on Debian based systems' do
      let(:facts) { {:osfamily => 'Debian'} }
      it { should contain_package('audit').with_name('auditd') }
    end

    context 'with a custom package name' do
      let(:params) { {'package_name' => 'custom-auditd-package'} }
      it { should contain_package('audit').with_name('custom-auditd-package') }
    end

end
