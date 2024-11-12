# modules/fstec/manifests/section_2_5_6.pp
class fstec::section_2_5_6 {
  # Описание: Устанавливает kernel.unprivileged_bpf_disabled=1 для запрета bpf.

  sysctl { 'kernel.unprivileged_bpf_disabled':
    value => '1',
  }

  exec { 'log_section_2_5_6':
    command => 'echo "Требование 2.5.6 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['kernel.unprivileged_bpf_disabled'],
  }
}
