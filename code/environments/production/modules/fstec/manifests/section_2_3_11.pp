class fstec::section_2_3_11 {
  # Получаем список пользователей из Hiera
  $users = lookup('fstec::users', { default_value => ['admin'] })

  $users.each |$user| {
    $home_dir = "/home/${user}"
    file { $home_dir:
      ensure  => directory,
      mode    => '0700',
      owner   => $user,
      group   => $user,
      require => File['/var/log/puppet_fstec'],
    }
  }

  # Логирование
  exec { 'log_section_2_3_11':
    command => "echo 'Требование 2.3.11 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => File['/var/log/puppet_fstec'],
  }
}
