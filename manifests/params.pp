# == Class: zabbix_alertscript_maintenance::params
#
# This class exists to
# 1. Declutter the default value assignment for class parameters.
# 2. Manage internally used module variables in a central place.
#
# Therefore, many operating system dependent differences (names, paths, ...)
# are addressed in here.
#
#
# This class is not intended to be used directly.
#
#
class zabbix_alertscript_maintenance::params {

### Default values for the parameters of the main module class, init.pp

## ensure
  $ensure = present

## enable
  $enable = true

## autoupgrade
  $autoupgrade = false

### Package specific in

## packages
  $package = $::osfamily ? {
    /(RedHat|Debian)/ => [ 'zabbix-alertscript-maintenance' ],
  }

## configdir
  $configdir = $::osfamily ? {
    /(RedHat|Debian)/ => '/etc/zabbix/alertscripts',
  }

## configfile
  $configfile = $::osfamily ? {
    /(RedHat|Debian)/ => 'maintmode.conf',
  }

## owner
  $owner = $::osfamily ? {
    /(RedHat|Debian)/ => 'zabbixsrv',
  }

## group
  $group = $::osfamily ? {
    /(RedHat|Debian)/ => 'zabbixsrv',
  }

## mode
  $mode = $::osfamily ? {
    /(RedHat|Debian)/ => '0640',
  }

## dirmode
  $dirmode = $::osfamily ? {
    /(RedHat|Debian)/ => '0755',
  }

## sourcedir
  $sourcedir = "puppet:///modules/${module_name}"

}
