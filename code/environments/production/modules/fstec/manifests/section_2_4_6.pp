class fstec::section_2_4_6 {
  fstec::grub_cmdline_linux { 'parameter_for_2_4_6':
    value  => 'example_parameter_value',
    notify => Class['fstec::update_grub'],
  }

  include fstec::update_grub

  exec { 'log_section_2_4_6':
    command => "echo 'Требование 2.4.6 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Fstec::Grub_cmdline_linux['parameter_for_2_4_6'],
  }
}
