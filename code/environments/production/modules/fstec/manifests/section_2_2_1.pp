# modules/fstec/manifests/section_2_2_1.pp
class fstec::section_2_2_1 {
  # Описание: Ограничивает доступ к команде su путем настройки PAM.
  
  if $facts['os']['family'] == 'RedHat' or $facts['os']['family'] == 'Debian' {
    file_line { 'restrict_su':
      ensure => present,
      path   => '/etc/pam.d/su',
      line   => 'auth required pam_wheel.so use_uid',
      match  => '^auth\s+required\s+pam_wheel.so',
    }
    
    group { 'wheel':
      ensure => present,
      gid    => 10,
    }
    
    $wheel_users = lookup('wheel::users', { default_value => [] })
    
    user { $wheel_users:
      ensure => present,
      groups => ['wheel'],
      require => Group['wheel'],
    }
        
    exec { 'log_section_2_2_1':
      command => 'echo "Требование 2.2.1 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
      path    => ['/usr/bin', '/bin'],
      require => [File_line['restrict_su'], Group['wheel']],
    }
  }
}
