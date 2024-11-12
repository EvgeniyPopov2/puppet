# modules/fstec/manifests/section_2_6_4.pp
class fstec::section_2_6_4 {
  # Описание: Устанавливает fs.protected_fifos=2 для защиты FIFO.

  sysctl { 'fs.protected_fifos':
    value => '2',
  }

  exec { 'log_section_2_6_4':
    command => 'echo "Требование 2.6.4 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['fs.protected_fifos'],
  }
}
