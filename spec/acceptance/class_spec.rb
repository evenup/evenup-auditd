require 'spec_helper_acceptance'

describe 'auditd classes' do

  context 'server' do

    case fact('osfamily')
    when 'RedHat'
      package_name = 'audit'
    when 'Debian'
      package_name = 'auditd'
    end
    service_name = 'auditd'

    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'auditd': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package(package_name) do
      it { is_expected.to be_installed }
    end

    describe service(service_name) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

  end # server

end
