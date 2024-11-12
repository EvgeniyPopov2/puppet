# modules/fstec/manifests/section_2_6_3.pp
class fstec::section_2_6_3 {
  # Описание: Устанавливает fs.protected_hardlinks=1 для защиты от атак через hardlinks.

  sysctl { 'fs.protected_hardlinks':
    value => '1',
  }

  exec { 'log_section_2_6_3':
    command => 'echo "Требование 2.6.3 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['fs.protected_hardlinks'],
  }
}
