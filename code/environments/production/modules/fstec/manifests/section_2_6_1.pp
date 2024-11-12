# modules/fstec/manifests/section_2_6_1.pp
class fstec::section_2_6_1 {
  # Описание: Устанавливает kernel.yama.ptrace_scope=3 для ограничения ptrace.

  sysctl { 'kernel.yama.ptrace_scope':
    value => '3',
  }

  exec { 'log_section_2_6_1':
    command => 'echo "Требование 2.6.1 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['kernel.yama.ptrace_scope'],
  }
}
