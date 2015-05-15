puppet-zabbix_alertscript_maintenance
==============
This is a simple module that allows for configuration of the [Maintenance
mode Alert script for Zabbix](https://github.com/gregswift/zabbix-alertscript-maintenance).

Examples
========

Basic install with minimal config based on alert script's documentation
```
class { 'zabbix_alertscript_maintenance'':
  password => 'somepassword'
}
```

Basic install, with full config
```
class { 'zabbix_alertscript_maintenance':
  ensure   => present,
  user     => 'maintenance',
  password => 'asdfladfujgaf',
  api      => 'https://localhost/zabbix',
}
```

Uninstall
```
class { 'zabbix_alertscript_maintenance':
  ensure => absent,
}
```
