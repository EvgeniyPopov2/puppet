class fstec::update_grub {
  exec { 'update-grub':
    command     => '/usr/sbin/update-grub',
    path        => ['/usr/sbin', '/sbin', '/usr/bin', '/bin'],
    refreshonly => true,
    unless      => 'test -f /var/lib/puppet/state/grub_updated',
    notify      => Exec['mark_grub_updated'],
  }

  exec { 'mark_grub_updated':
    command => 'touch /var/lib/puppet/state/grub_updated',
    path    => ['/usr/bin', '/bin'],
    refreshonly => true,
  }
}
