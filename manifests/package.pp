# == Class: zabbix_alertscript_maintenance::package
#
# This class exists to coordinate all software package management related
# actions, functionality and logical units in a central place.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'zabbix_alertscript_maintenance::package': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
class zabbix_alertscript_maintenance::package {
## set params: in operation
  if $zabbix_alertscript_maintenance::ensure == present {
    $package_ensure = $zabbix_alertscript_maintenance::autoupgrade ? {
      true  => latest,
      false => present,
    }

## set params: removal
  } else {
    $package_ensure = absent
  }

### Manage actions

  package { $zabbix_alertscript_maintenance::params::package:
    ensure => $package_ensure,
  }

}
