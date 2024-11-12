# modules/fstec/manifests/section_2_4_8.pp
class fstec::section_2_4_8 {
  # Описание: Устанавливает net.core.bpf_jit_harden=2.

  sysctl { 'net.core.bpf_jit_harden':
    value => '2',
  }

  exec { 'log_section_2_4_8':
    command => 'echo "Требование 2.4.8 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['net.core.bpf_jit_harden'],
  }
}
