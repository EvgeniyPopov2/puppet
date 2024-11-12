# modules/fstec/manifests/section_2_3_9.pp
class fstec::section_2_3_9 {
  # Описание: Проверяет и устанавливает корректные права доступа к SUID/SGID-приложениям.

  exec { 'secure_suid_sgid_files':
    command => 'find / -perm /6000 -type f -exec chmod go-w {} +',
    path    => ['/usr/bin', '/bin'],
    onlyif  => 'find / -perm /6000 -type f | grep -q .',
  }

  # Опционально: удаление лишних SUID/SGID-битов
  # Можно задать "белый список" в Hiera
  $suid_sgid_whitelist = lookup('suid_sgid::whitelist', { default_value => [] })

  exec { 'remove_unwanted_suid_sgid':
    command => 'find / -perm /6000 -type f | grep -v -f /tmp/suid_sgid_whitelist.txt | xargs chmod u-s,g-s',
    path    => ['/usr/bin', '/bin'],
    onlyif  => 'test -s /tmp/suid_sgid_whitelist.txt',
    require => File['/tmp/suid_sgid_whitelist.txt'],
  }

  file { '/tmp/suid_sgid_whitelist.txt':
    ensure  => file,
    content => join($suid_sgid_whitelist, "\n"),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  exec { 'log_section_2_3_9':
    command => 'echo "Требование 2.3.9 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => [Exec['secure_suid_sgid_files'], Exec['remove_unwanted_suid_sgid']],
  }
}
