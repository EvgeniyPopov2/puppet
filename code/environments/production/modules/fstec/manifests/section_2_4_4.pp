class fstec::section_2_4_4 {
  fstec::grub_cmdline_linux { 'another_grub_parameter':
    value  => 'another_parameter_value',
    notify => Class['fstec::update_grub'],
  }

  include fstec::update_grub

  exec { 'log_section_2_4_4':
    command => "echo 'Требование 2.4.4 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Fstec::Grub_cmdline_linux['another_grub_parameter'],
  }
}
