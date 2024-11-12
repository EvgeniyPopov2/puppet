# modules/fstec/manifests/section_2_5_10.pp
class fstec::section_2_5_10 {
  # Описание: Устанавливает vm.mmap_min_addr=4096 или больше.

  sysctl { 'vm.mmap_min_addr':
    value => '4096',
  }

  exec { 'log_section_2_5_10':
    command => 'echo "Требование 2.5.10 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['vm.mmap_min_addr'],
  }
}
