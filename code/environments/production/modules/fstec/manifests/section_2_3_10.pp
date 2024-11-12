# /etc/puppetlabs/code/environments/production/modules/fstec/manifests/section_2_3_10.pp
class fstec::section_2_3_10 {
  $users = ['admin']

  $files = [
    '.bash_history', '.history', '.sh_history', '.bash_profile',
    '.bashrc', '.profile', '.bash_logout', '.rhosts'
  ]

  $users.each |$user| {
    $home_dir = "/home/${user}"
    $files.each |$file| {
      $file_path = "${home_dir}/${file}"

      # Используем exec для изменения прав доступа, если файл существует
      exec { "set_permissions_${user}_${file}":
        command => "chmod 0700 '${file_path}' && chown ${user}:${user} '${file_path}'",
        onlyif  => "test -e '${file_path}'",
        path    => ['/usr/bin', '/bin'],
        require => File['/var/log/puppet_fstec'],
      }
    }
  }

  # Логирование
  exec { 'log_section_2_3_10':
    command => "echo 'Требование 2.3.10 применено на ${facts['networking']['fqdn']}' >> /var/log/puppet_fstec/apply.log",
    path    => ['/usr/bin', '/bin'],
    require => File['/var/log/puppet_fstec'],
  }
}
