# Run puppet again if notified to do so
# Copyright (C) 2012-2013+ James Shubin
# Written by James Shubin <james@shubin.ca>
# Written by Radu Dima 
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class again (
  Integer[0] $delay = 10,
  String[1] $rubyexe = '/opt/puppetlabs/puppet/bin/ruby',
  String[1] $lockfile = '/opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock',
  String[1] $puppetbin = '/opt/puppetlabs/bin/puppet',
            )
{



  include ::again::vardir

  $vardir = regsubst($::again::vardir::module_vardir, '\/$', '')

  # store 'again' specific code in a separate directory
  file { "${vardir}/again/":
    ensure  => directory,  # make sure this is a directory
    recurse => true,  # don't recurse into directory
    purge   => true,    # don't purge unmanaged files
    force   => true,    # don't purge subdirs and links
    require => File["${vardir}/"],
  }

  file { "${vardir}/again/again.rb":
    # NOTE: this is actually templated, but no templating
    # is actually being used. This gives us the option to
    # pass in some variables if we decide we would like a
    # way to get values in other than via command line...
    # we could pass in some environ data or other data...
                ensure => present,
    owner              => root,
    group              => root,
    mode               => '0750',  # if you're not root, you can't run it!
    content            => template('again/again.rb.erb'),
    require            => File["${vardir}/again/"],
  }

  # notify this command whenever you want to trigger another puppet run!
  exec { 'again':
                command => "${vardir}/again/again.rb",
    logoutput           => on_failure,
    refreshonly         => true,  # run whenever someone requests it!
                require =>  File["${vardir}/again/again.rb"],
  }
}

