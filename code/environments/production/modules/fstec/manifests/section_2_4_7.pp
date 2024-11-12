# /etc/puppetlabs/code/environments/production/modules/fstec/manifests/section_2_4_7.pp
class fstec::section_2_4_7 {
  # Вызов ресурса fstec::grub_cmdline_linux
  fstec::grub_cmdline_linux { 'parameter_for_2_4_7':
    value  => 'example_parameter_value',
    notify => Class['fstec::update_grub'],
  }

  # Включаем класс update_grub для обновления Grub
  include fstec::update_grub

  # Логирование
  exec { 'log_section_2_4_7':
    command => "echo 'Требование 2.4.7 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Fstec::Grub_cmdline_linux['parameter_for_2_4_7'],
  }
}
