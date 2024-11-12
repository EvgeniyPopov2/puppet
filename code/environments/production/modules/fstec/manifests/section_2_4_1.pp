# modules/fstec/manifests/section_2_4_1.pp
class fstec::section_2_4_1 {
  # Описание: Устанавливает kernel.dmesg_restrict=1 для ограничения доступа к журналу ядра.

  sysctl { 'kernel.dmesg_restrict':
    value => '1',
  }

  exec { 'log_section_2_4_1':
    command => 'echo "Требование 2.4.1 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['kernel.dmesg_restrict'],
  }
}
