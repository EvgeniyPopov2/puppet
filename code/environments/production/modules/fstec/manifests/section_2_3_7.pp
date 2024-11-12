# modules/fstec/manifests/section_2_3_7.pp
class fstec::section_2_3_7 {
  # Описание: Устанавливает корректные права доступа к пользовательским файлам заданий cron.

  exec { 'secure_user_cron_files':
    command => 'find /var/spool/cron/crontabs -type f -exec chmod go-w {} +',
    path    => ['/usr/bin', '/bin'],
    onlyif  => 'test -d /var/spool/cron/crontabs',
  }

  exec { 'log_section_2_3_7':
    command => 'echo "Требование 2.3.7 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Exec['secure_user_cron_files'],
  }
}
