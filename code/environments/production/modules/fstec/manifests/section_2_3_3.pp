# modules/fstec/manifests/section_2_3_3.pp
class fstec::section_2_3_3 {
  # Описание: Устанавливает корректные права доступа к файлам, выполняющимся через cron.
  
  exec { 'secure_cron_files':
    command => 'for f in $(grep -rE "^[^#]" /etc/crontab /etc/cron.d/ /var/spool/cron/ | awk \'{print $6}\'); do chmod go-w $f; done',
    path    => ['/usr/bin', '/bin'],
  }
    
  exec { 'log_section_2_3_3':
    command => 'echo "Требование 2.3.3 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Exec['secure_cron_files'],
  }
}
