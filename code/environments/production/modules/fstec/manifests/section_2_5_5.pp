# modules/fstec/manifests/section_2_5_5.pp
class fstec::section_2_5_5 {
  # Описание: Устанавливает user.max_user_namespaces=0 для ограничения использования user namespaces.

  sysctl { 'user.max_user_namespaces':
    value => '0',
  }

  exec { 'log_section_2_5_5':
    command => 'echo "Требование 2.5.5 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['user.max_user_namespaces'],
  }
}
