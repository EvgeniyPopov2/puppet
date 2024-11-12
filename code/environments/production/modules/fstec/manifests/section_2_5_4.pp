# modules/fstec/manifests/section_2_5_4.pp
class fstec::section_2_5_4 {
  # Описание: Устанавливает kernel.kexec_load_disabled=1 для запрета использования kexec_load.

  sysctl { 'kernel.kexec_load_disabled':
    value => '1',
  }

  exec { 'log_section_2_5_4':
    command => 'echo "Требование 2.5.4 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['kernel.kexec_load_disabled'],
  }
}
