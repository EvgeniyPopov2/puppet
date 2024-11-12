# /etc/puppetlabs/code/environments/production/modules/fstec/manifests/section_2_5_1.pp
class fstec::section_2_5_1 {
  fstec::grub_cmdline_linux { 'parameter_for_2_5_1':
    value  => 'example_parameter_value',
    notify => Class['fstec::update_grub'],
  }

  include fstec::update_grub

  exec { 'log_section_2_5_1':
    command => "echo 'Требование 2.5.1 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Fstec::Grub_cmdline_linux['parameter_for_2_5_1'],
  }
}
