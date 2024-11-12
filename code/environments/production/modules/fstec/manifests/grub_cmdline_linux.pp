# modules/fstec/manifests/grub_cmdline_linux.pp
define fstec::grub_cmdline_linux($value, $ensure = 'present') {
  # Используем file_line для редактирования /etc/default/grub
  file_line { "grub_${title}":
    path  => '/etc/default/grub',
    line  => "GRUB_CMDLINE_LINUX=\"${value}\"",
    match => '^GRUB_CMDLINE_LINUX=',
    notify => Exec['update-grub'],
  }
}
