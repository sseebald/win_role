#
# The `puppetmaster` role sets up a master system, synchronizes files from
# Amazon, and generally enables SE Team specific patterns dependent on master
# capabilities.
#
class role::master (
  $srv_root                 = '/var/seteam-files',
) {
  # Custom PE Console configuration
  include git
  include apache

  # Puppet master firewall rules
  include profile::firewall
  Firewall {
    require => Class['profile::firewall::pre'],
    before  => Class['profile::firewall::post'],
    chain   => 'INPUT',
    proto   => 'tcp',
    action  => 'accept',
  }
  firewall { '110 puppetmaster allow all': dport  => '8140';  }
  firewall { '110 dashboard allow all':    dport  => '443';   }
  firewall { '110 mcollective allow all':  dport  => '61613'; }
  firewall { '110 apache allow all':       dport  => '80';    }

  apache::vhost { 'seteam-files':
    vhost_name    => '*',
    port          => '80',
    docroot       => $srv_root,
    priority      => '10',
    docroot_owner => 'vagrant',
    docroot_group => 'vagrant',
  }

}
