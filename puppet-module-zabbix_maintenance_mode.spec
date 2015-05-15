%define base_name zabbix_alertscript_maintenance

Name:      puppet-module-%{base_name}
Version:   0.1.0
Release:   1
BuildArch: noarch
Summary:   Puppet module to configure %{base_name}
License:   GPLv3+
URL:       http://github.com/gregswift/%{base_name}
Source0:   %{name}.tgz

%description
Puppet configuration module for the Zabbix Maintenance mode Alert Script

%define module_dir /usr/share/puppet/modules/%{base_name}

%prep
%setup -q -c -n %{base_name}

%build

%install
mkdir -p %{buildroot}%{module_dir}
cp -pr * %{buildroot}%{module_dir}/

%files
%defattr (0644,root,root)
%{module_dir}

%changelog
* Fri May 15 2015 Greg Swift <greg.swift@rackspace.com> - 0.1.0-1
- Initial version of the package
