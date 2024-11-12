# modules/fstec/manifests/section_2_6_6.pp
class fstec::section_2_6_6 {
  # Описание: Устанавливает fs.suid_dumpable=0 для запрета создания core dump для SUID-приложений.

  sysctl { 'fs.suid_dumpable':
    value => '0',
  }

  exec { 'log_section_2_6_6':
    command => 'echo "Требование 2.6.6 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['fs.suid_dumpable'],
  }
}
