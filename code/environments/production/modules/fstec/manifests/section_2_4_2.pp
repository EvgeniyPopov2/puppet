# modules/fstec/manifests/section_2_4_2.pp
class fstec::section_2_4_2 {
  # Описание: Устанавливает kernel.kptr_restrict=2 для скрытия ядерных адресов.

  sysctl { 'kernel.kptr_restrict':
    value => '2',
  }

  exec { 'log_section_2_4_2':
    command => 'echo "Требование 2.4.2 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['kernel.kptr_restrict'],
  }
}
