# modules/fstec/manifests/section_2_3_4.pp
class fstec::section_2_3_4 {
  # Описание: Устанавливает корректные права доступа к файлам, выполняемым с помощью sudo.
  
  # Предполагается, что список файлов для проверки задан в Hiera
  $sudo_files = lookup('sudo::files', { default_value => [] })
  
  file { $sudo_files:
    owner => 'root',
    group => 'root',
    mode  => '0755',
    require => Package['sudo'],
  }
    
  exec { 'log_section_2_3_4':
    command => 'echo "Требование 2.3.4 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => File[$sudo_files],
  }
}
