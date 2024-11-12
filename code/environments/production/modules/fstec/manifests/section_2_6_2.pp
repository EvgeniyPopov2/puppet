# modules/fstec/manifests/section_2_6_2.pp
class fstec::section_2_6_2 {
  # Описание: Устанавливает fs.protected_symlinks=1 для защиты от атак через symlinks.

  sysctl { 'fs.protected_symlinks':
    value => '1',
  }

  exec { 'log_section_2_6_2':
    command => 'echo "Требование 2.6.2 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['fs.protected_symlinks'],
  }
}
