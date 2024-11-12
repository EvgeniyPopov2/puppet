# /etc/puppetlabs/code/environments/production/modules/fstec/manifests/section_2_1_1.pp
class fstec::section_2_1_1 {
  # Блокируем учетные записи с пустыми паролями
  exec { 'lock_empty_passwords':
    command => '/usr/bin/passwd -l $(awk -F: \'$2==""{print $1}\' /etc/shadow)',
    onlyif  => 'awk -F: \'$2==""{exit 0} END{exit 1}\' /etc/shadow',
    path    => ['/usr/bin', '/bin'],
  }

  # Логирование
  exec { 'log_section_2_1_1':
    command => "echo 'Требование 2.1.1 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => Exec['lock_empty_passwords'],
  }
}
