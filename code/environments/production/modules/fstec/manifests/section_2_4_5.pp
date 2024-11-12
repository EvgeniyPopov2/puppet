# /etc/puppetlabs/code/environments/production/modules/fstec/manifests/section_2_4_5.pp
class fstec::section_2_4_5 {
  # Используем ресурс fstec::grub_cmdline_linux для добавления параметра 'page_poison'
  fstec::grub_cmdline_linux { 'page_poison':
    value  => 'page_poison=1',
    notify => Exec['update-grub'],  # Ссылаемся на существующую команду update-grub
  }

  # Логирование применения изменений
  exec { 'log_section_2_4_5':
    command => "echo 'Требование 2.4.5 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Fstec::Grub_cmdline_linux['page_poison'],
  }
}
