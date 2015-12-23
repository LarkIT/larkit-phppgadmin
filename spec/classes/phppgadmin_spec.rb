require 'spec_helper'

describe 'phppgadmin' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "phppgadmin class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('phppgadmin::params') }
          it { is_expected.to contain_class('phppgadmin::install').that_comes_before('phppgadmin::config') }
          it { is_expected.to contain_class('phppgadmin::config') }

          it { is_expected.to contain_package('phpPgAdmin').with(:ensure => 'present') }
          it { is_expected.to contain_file('/etc/phpPgAdmin/config.inc.php').with(:owner => 'apache', :group => 'apache')}
          it { is_expected.not_to contain_file('/etc/phpPgAdmin/config.inc.php').with(:content => /\$conf\['servers'\]/)}
        end

        context "set package, version, config file, user, group" do
          let(:params) { { :package_name => 'myAdmin', :version => '1.2.3', :config_file => '/var/www/html/phppgadmin/config.inc.php', :www_user => 'www', :www_group => 'www' } }
          it { is_expected.to contain_package('myAdmin').with(:ensure => '1.2.3') }
          it { is_expected.to contain_file('/var/www/html/phppgadmin/config.inc.php').with(:owner => 'www', :group => 'www')}
        end

        context "configure servers, app config" do
          let(:params) do
            {
              :servers => [{'host' => 'host1'}, {'host' => 'host2', 'port' => 1234 }],
              :config => {'UploadDir' => '/tmp/upload'}
            }
          end

          it { is_expected.to contain_file('/etc/phpPgAdmin/config.inc.php').with(:content => /\$conf\['servers'\]\[0\]\['host'\] = 'host1';/)}
          it { is_expected.to contain_file('/etc/phpPgAdmin/config.inc.php').with(:content => /\$conf\['servers'\]\[1\]\['host'\] = 'host2';/)}
          it { is_expected.to contain_file('/etc/phpPgAdmin/config.inc.php').with(:content => /\$conf\['servers'\]\[1\]\['port'\] = '1234';/)}
          it { is_expected.to contain_file('/etc/phpPgAdmin/config.inc.php').with(:content => /\$conf\['UploadDir'\] = '\/tmp\/upload';/)}
        end

        context "failures" do
          context "config not a hash" do
            let(:params) { { :config => 'wrong' } }
            it { expect { is_expected.to contain_class('phppgadmin') }.to raise_error(Puppet::Error, /::phppgadmin::config must be a hash/) }
          end

          context "servers not an array" do
            let(:params) { { :servers => 'wrong' } }
            it { expect { is_expected.to contain_class('phppgadmin') }.to raise_error(Puppet::Error, /::phppgadmin::servers must be an array of hash/) }
          end

          context "invalid config_file path" do
            let(:params) { { :config_file => 'wrong' } }
            it { expect { is_expected.to contain_class('phppgadmin') }.to raise_error(Puppet::Error, /is not an absolute path/) }
          end
        end #failures
      end # on os
    end
  end

  context 'unsupported operating system' do
    describe 'phppgadmin class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('phppgadmin') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
