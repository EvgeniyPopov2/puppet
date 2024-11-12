class fstec::section_2_3_5 {
  $rc_dirs = ['/etc/rc.d/rc0.d', '/etc/rc.d/rc1.d', '/etc/rc.d/rc2.d', '/etc/rc.d/rc3.d', '/etc/rc.d/rc4.d', '/etc/rc.d/rc5.d', '/etc/rc.d/rc6.d']

  file { $rc_dirs:
    ensure       => directory,
    recurse      => true,
    mode         => '0755',
    owner        => 'root',
    group        => 'root',
    ignore       => ['.', '..'],
    recurselimit => 1,
  }

  if $facts['service_provider'] == 'systemd' {
    exec { 'secure_systemd_services':
      command => 'find /lib/systemd/system/ /etc/systemd/system/ -type f -name "*.service" -exec chmod o-w {} +',
      path    => ['/usr/bin', '/bin'],
    }

    # Определяем $requires, включая Exec['secure_systemd_services']
    $requires = [File[$rc_dirs], Exec['secure_systemd_services']]
  } else {
    # Определяем $requires без Exec['secure_systemd_services']
    $requires = [File[$rc_dirs]]
  }

  exec { 'log_section_2_3_5':
    command => "echo 'Требование 2.3.5 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => $requires,
  }
}
