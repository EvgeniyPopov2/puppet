# /etc/puppetlabs/code/environments/production/modules/fstec/manifests/section_2_5_3.pp
class fstec::section_2_5_3 {
  # Добавляем параметр загрузки ядра 'debugfs=no-mount' с помощью ресурса fstec::grub_cmdline_linux
  fstec::grub_cmdline_linux { 'disable_debugfs':
    value  => 'debugfs=no-mount',
    notify => Class['fstec::update_grub'],
  }

  # Включаем класс update_grub для обновления GRUB
  include fstec::update_grub

  # Логирование
  exec { 'log_section_2_5_3':
    command => "echo 'Требование 2.5.3 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Fstec::Grub_cmdline_linux['disable_debugfs'],
  }
}
