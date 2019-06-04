#Puppet Again Module 

This is puppet module for running the puppet agent again in case it's needed
It's based on existing puppet again module from
James Shubin
The actual script that starts puppet is written in ruby now 

Please read the INSTALL file for instructions on getting this installed.
Look in the examples/ folder for usage. If none exist, please contribute one!
This code may be a work in progress. The interfaces may change without notice.
Patches are welcome, but please be patient. They are best received by email.
Please ping me if you have big changes in mind, before you write a giant patch.

# Module specific notes:
* This module is a useful for triggering puppet agent by notified this module
* Can be used when puppet is applying configuration for the first time
* Tested on RHEL 6/7. Should work on other Distro's
* Tested with Puppet5 and ruby 2.4
* Parameters can be changed, delay, puppet binary location, ruby location
* Default parameters will trigger the run 10sec after and uses the built in puppet ruby

# Dependencies:
* puppetlabs-stdlib (required)
* ruby
* puppet5 

# Usage:
 include again
  service { 'sssd':
    ensure      => running,
    enable      => true,
    notify      => Exec['again'],
  }
or Service['sssd'] ~> Exec['again']

Radu Dima < dima.radu.lucian@gmail.com >

