# modules/fstec/manifests/section_2_5_11.pp
class fstec::section_2_5_11 {
  # Описание: Устанавливает kernel.randomize_va_space=2 для включения ASLR.

  sysctl { 'kernel.randomize_va_space':
    value => '2',
  }

  exec { 'log_section_2_5_11':
    command => 'echo "Требование 2.5.11 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['kernel.randomize_va_space'],
  }
}
