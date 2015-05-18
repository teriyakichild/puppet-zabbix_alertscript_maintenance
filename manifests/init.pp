# == Class: zabbix_alertscript_maintenance
#
# This class is able to install or remove zabbix_alertscript_maintenance on a node.
#
# === Parameters
#
# [*ensure*]
# String. Controls if the managed resources shall be <tt>present</tt> or
# <tt>absent</tt>. If set to <tt>absent</tt>:
# * The managed software packages are being uninstalled.
# * Any traces of the packages will be purged as good as possible. This may
# include existing configuration files. The exact behavior is provider
# dependent. Q.v.:
# * Puppet type reference: {package, "purgeable"}[http://j.mp/xbxmNP]
# * {Puppet's package provider source code}[http://j.mp/wtVCaL]
# * System modifications (if any) will be reverted as good as possible
# (e.g. removal of created users, services, changed log settings, ...).
# * This is thus destructive and should be used with care.
# Defaults to <tt>present</tt>.
#
# [*autoupgrade*]
# Boolean. If set to <tt>true</tt>, any managed package gets upgraded
# on each Puppet run when the package provider is able to find a newer
# version than the present one. The exact behavior is provider dependent.
# Q.v.:
# * Puppet type reference: {package, "upgradeable"}[http://j.mp/xbxmNP]
# * {Puppet's package provider source code}[http://j.mp/wtVCaL]
# Defaults to <tt>false</tt>.
#
# The default values for the parameters are set in zabbix_alertscript_maintenance::params. Have
# a look at the corresponding <tt>params.pp</tt> manifest file if you need more
# technical information about them.
#
# [*user*]
# String. Defining the user that should be populated in the configuration file.
# Defaults to <tt>Maintenance</tt> which is the default for the app.
#
# [*password*]
# String. REQUIRED. Defines password for hte user, we don't have a default so
# fail when undef.
#
# [*endpoint*]
# String. The entrypoint for the Zabbix endpoint.
# Defaults to <tt>https://localhost/zabbix</tt>, which is the default for the app.
#
#
# === Examples
#
# * Installation:
#
# class { 'zabbix_alertscript_maintenance':
#   password => 'asdfasdfawtert',
# }
#
# * Removal/decommissioning:
#
# class { 'zabbix_alertscript_maintenance': ensure => 'absent' }
#
#
class zabbix_alertscript_maintenance (
  $ensure      = $zabbix_alertscript_maintenance::params::ensure,
  $autoupgrade = $zabbix_alertscript_maintenance::params::autoupgrade,
  $user        = 'Maintenance',
  $password    = undef,
  $api         = 'https://localhost/zabbix',
) inherits zabbix_alertscript_maintenance::params {

### Validate parameters

## ensure
  if ! ($ensure in [ present, absent ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  } else {
    $file_ensure = $ensure ? {
      present => file,
      absent  => absent,
    }
    $dir_ensure = $ensure ? {
      present => directory,
      absent  => absent,
    }
  }
  if $::debug {
    if $ensure != $zabbix_alertscript_maintenance::params::ensure {
      debug('$ensure overridden by class parameter')
    }
    debug("\$ensure = '${ensure}'")
  }

## enable - we don't validate because all standard options are acceptable
  if $::debug {
    if $enable != $zabbix_alertscript_maintenance::params::enable {
      debug('$enable overridden by class parameter')
    }
    debug("\$enable = '${enable}'")
  }

## autoupgrade
  validate_bool($autoupgrade)
  if $::debug {
    if $autoupgrade != $zabbix_alertscript_maintenance::params::autoupgrade {
      debug('$autoupgrade overridden by class parameter')
    }
    debug("\$autoupgrade = '${autoupgrade}'")
  }

## password
  if $password == undef {
    fail("password must be provided for this module")
  }

### Manage actions

## package(s)
  class { 'zabbix_alertscript_maintenance::package': }

## files/directories
  file { $zabbix_alertscript_maintenance::params::configdir:
    ensure  => $dir_ensure,
    mode    => $zabbix_alertscript_maintenance::params::dirmode,
    owner   => $zabbix_alertscript_maintenance::params::owner,
    group   => $zabbix_alertscript_maintenance::params::group,
    require => Package[$zabbix_alertscript_maintenance::params::package],
  }
  file { "${zabbix_alertscript_maintenance::params::configdir}/${zabbix_alertscript_maintenance::params::configfile}":
    ensure  => $file_ensure,
    mode    => $zabbix_alertscript_maintenance::params::mode,
    owner   => $zabbix_alertscript_maintenance::params::owner,
    group   => $zabbix_alertscript_maintenance::params::group,
    content => template("${module_name}/${zabbix_alertscript_maintenance::params::configfile}.erb")
    require => Package[$zabbix_alertscript_maintenance::params::package],
  }
}
