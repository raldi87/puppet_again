## Puppet Again Module 

This is puppet module for running the puppet agent again in case it's needed
It's based on existing puppet again module from
James Shubin
The actual script that starts puppet is written in Ruby now 

Please read the INSTALL file for instructions on getting this installed.
Look in the examples/ folder for usage. 

# Module specific notes:
* This module is a useful for triggering puppet agent by notified this module
* Can be used when puppet is applying configuration for the first time
* Tested on RHEL 6/7. Should work on other Distro's
* Tested with Puppet5 and ruby 2.4
* Parameters can be changed in hiera delay, puppet binary location, ruby location
* Default parameters will trigger the run 10sec after and uses the built in puppet ruby

# Dependencies:
* puppetlabs-stdlib (required)
* ruby
* puppet5 

# Usage:
```
 include again
  service { 'sssd':
    ensure      => running,
    enable      => true,
    notify      => Exec['again'],
  }
or Service['sssd'] ~> Exec['again']
```
Radu Dima < dima.radu.lucian@gmail.com >

