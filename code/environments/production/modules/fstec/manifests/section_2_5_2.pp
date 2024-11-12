# modules/fstec/manifests/section_2_5_2.pp
class fstec::section_2_5_2 {
  # Описание: Устанавливает kernel.perf_event_paranoid=3 для ограничения доступа к событиям производительности.

  sysctl { 'kernel.perf_event_paranoid':
    value => '3',
  }

  exec { 'log_section_2_5_2':
    command => 'echo "Требование 2.5.2 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['kernel.perf_event_paranoid'],
  }
}
