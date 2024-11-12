# modules/fstec/manifests/section_2_2_2.pp
class fstec::section_2_2_2 {
  # Описание: Ограничивает список пользователей, которым разрешено использовать sudo.
  
  package { 'sudo':
    ensure => installed,
  }
  
  $sudo_users = lookup('sudo::users', { default_value => [] })
  
  file { '/etc/sudoers.d/limited_users':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => template('fstec/limited_users.erb'),
    require => Package['sudo'],
  }
    
  exec { 'log_section_2_2_2':
    command => 'echo "Требование 2.2.2 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => File['/etc/sudoers.d/limited_users'],
  }
}
