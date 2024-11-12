# modules/fstec/manifests/section_2_3_1.pp
class fstec::section_2_3_1 {
  # Описание: Устанавливает корректные права доступа к /etc/passwd, /etc/group, /etc/shadow.
  
  file { '/etc/passwd':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  
  file { '/etc/group':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  
  file { '/etc/shadow':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
  }
    
  exec { 'log_section_2_3_1':
    command => 'echo "Требование 2.3.1 применено на ${facts["networking"]["fqdn"]}" >> /var/log/puppet_fstec/apply.log',
    path    => ['/usr/bin', '/bin'],
    require => [File['/etc/passwd'], File['/etc/group'], File['/etc/shadow']],
  }
}
