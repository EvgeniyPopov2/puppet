class fstec::section_2_3_8 {
  # Описание: Проверяет и устанавливает корректные права доступа к стандартным исполняемым файлам и библиотекам.

  $paths = ['/bin', '/usr/bin', '/lib', '/lib64', '/usr/lib', '/usr/lib64']

  # Изменяем права доступа и владельца для стандартных путей
  exec { 'secure_system_paths':
    command => "find ${paths.join(' ')} -xdev -type f -exec chmod 0755 {} + -exec chown root:root {} +",
    path    => ['/usr/bin', '/bin'],
  }

  # Модули ядра
  if $facts['kernel'] == 'Linux' {
    $kernel_version = $facts['kernelrelease']
    exec { 'secure_kernel_modules':
      command => "find /lib/modules/${kernel_version} -xdev -type f -exec chmod 0755 {} + -exec chown root:root {} +",
      path    => ['/usr/bin', '/bin'],
    }
  }

  # Логирование
  exec { 'log_section_2_3_8':
    command => "echo 'Требование 2.3.8 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Exec['secure_system_paths'],
  }
}
