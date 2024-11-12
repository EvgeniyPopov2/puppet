# /etc/puppetlabs/code/environments/production/modules/fstec/manifests/section_2_5_9.pp
class fstec::section_2_5_9 {
  # Используем ресурс fstec::grub_cmdline_linux с полным именем
  fstec::grub_cmdline_linux { 'tsx':
    ensure => present,
    value  => 'tsx=off',
    notify => Class['fstec::update_grub'],
  }

  # Включаем класс fstec::update_grub
  include fstec::update_grub

  # Логирование применения изменений
  exec { 'log_section_2_5_9':
    command => "echo 'Требование 2.5.9 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Fstec::Grub_cmdline_linux['tsx'],
  }
}
