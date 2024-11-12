# modules/fstec/manifests/section_2_3_6.pp
class fstec::section_2_3_6 {
  # Описание: Устанавливает корректные права доступа к системным файлам cron.
  
  $cron_files = ['/etc/crontab', '/etc/cron.d', '/etc/cron.hourly', '/etc/cron.daily', '/etc/cron.weekly', '/etc/cron.monthly']
  
  file { $cron_files:
    recurse => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ignore  => ['.', '..'],
  }
    
  exec { 'log_section_2_3_6':
    command => 'echo "Требование 2.3.6 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => File[$cron_files],
  }
}
