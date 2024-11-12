# modules/fstec/manifests/section_2_5_8.pp
class fstec::section_2_5_8 {
  # Описание: Устанавливает dev.tty.ldisc_autoload=0 для запрета автозагрузки модулей линии терминала.

  sysctl { 'dev.tty.ldisc_autoload':
    value => '0',
  }

  exec { 'log_section_2_5_8':
    command => 'echo "Требование 2.5.8 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => Sysctl['dev.tty.ldisc_autoload'],
  }
}
