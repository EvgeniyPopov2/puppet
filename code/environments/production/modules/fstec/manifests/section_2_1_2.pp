class fstec::section_2_1_2 {
  # Описание: Отключает возможность входа суперпользователя по SSH.

  # Определение службы SSH в зависимости от семейства ОС
  $ssh_service = $facts['os']['family'] ? {
    'RedHat' => 'sshd',
    'Debian' => 'ssh',
    default  => 'sshd',
  }

  # Убедитесь, что SSH установлен
  if $ssh_service {
    # Изменение конфигурации /etc/ssh/sshd_config
    file_line { 'disable_root_ssh_login':
      ensure => present,
      path   => '/etc/ssh/sshd_config',
      line   => 'PermitRootLogin no',
      match  => '^PermitRootLogin',
      notify => Service[$ssh_service],
    }

    # Управление службой SSH
    service { $ssh_service:
      ensure     => running,
      enable     => true,
      hasrestart => true,
      require    => File_line['disable_root_ssh_login'],
    }

    # Логирование изменений
    exec { 'log_section_2_1_2':
      command => 'echo "Требование 2.1.2 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
      path    => ['/usr/bin', '/bin'],
      require => File_line['disable_root_ssh_login'],
    }
  }
}
