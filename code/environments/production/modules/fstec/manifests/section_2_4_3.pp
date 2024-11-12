class fstec::section_2_4_3 {
  fstec::grub_cmdline_linux { 'init_on_alloc':
    value  => 'init_on_alloc=1',
    notify => Class['fstec::update_grub'],
  }

  include fstec::update_grub

  exec { 'log_section_2_4_3':
    command => "echo 'Требование 2.4.3 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Fstec::Grub_cmdline_linux['init_on_alloc'],
  }
}
