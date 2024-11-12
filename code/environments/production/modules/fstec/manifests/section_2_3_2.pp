class fstec::section_2_3_2 {
  # Скрипт для изменения прав доступа к исполняемым файлам запущенных процессов
  $script_content = @("SCRIPT")
    #!/bin/bash
    for pid in $(ps -e -o pid=); do
      exe_path=$(readlink -f /proc/$pid/exe 2>/dev/null)
      if [[ -n "$exe_path" && -f "$exe_path" && ! "$exe_path" =~ ^/proc/ ]]; then
        chmod go-w "$exe_path"
        chown root:root "$exe_path"
      fi
    done
  | SCRIPT

  # Создаём временный скрипт на узле
  file { '/tmp/fix_process_permissions.sh':
    ensure  => file,
    mode    => '0755',
    content => $script_content,
  }

  # Выполняем скрипт
  exec { 'fix_process_permissions':
    command     => '/bin/bash /tmp/fix_process_permissions.sh',
    path        => ['/usr/bin', '/bin'],
    require     => File['/tmp/fix_process_permissions.sh'],
    refreshonly => false,
    notify      => Exec['remove_fix_process_script'],
  }

  # Удаляем скрипт после выполнения (опционально)
  exec { 'remove_fix_process_script':
    command     => '/bin/rm -f /tmp/fix_process_permissions.sh',
    path        => ['/usr/bin', '/bin'],
    refreshonly => true,
  }

  # Логирование
  exec { 'log_section_2_3_2':
    command => "echo 'Требование 2.3.2 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Exec['fix_process_permissions'],
  }
}
