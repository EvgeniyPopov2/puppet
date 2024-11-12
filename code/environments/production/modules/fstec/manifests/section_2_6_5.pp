# modules/fstec/manifests/section_2_6_5.pp
class fstec::section_2_6_5 {
  # Описание: Устанавливает fs.protected_regular=2 для защиты обычных файлов.

  sysctl { 'fs.protected_regular':
    value => '2',
  }

  exec { 'log_section_2_6_5':
    command => 'echo "Требование 2.6.5 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['fs.protected_regular'],
  }
}
