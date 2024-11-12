# modules/fstec/manifests/section_2_5_7.pp
class fstec::section_2_5_7 {
  # Описание: Устанавливает vm.unprivileged_userfaultfd=0 для запрета userfaultfd.

  sysctl { 'vm.unprivileged_userfaultfd':
    value => '0',
  }

  exec { 'log_section_2_5_7':
    command => 'echo "Требование 2.5.7 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['vm.unprivileged_userfaultfd'],
  }
}
