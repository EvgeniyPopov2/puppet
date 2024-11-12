# modules/fstec/manifests/init.pp
class fstec {
  # Объявление директории для логов, чтобы избежать дублирования
  file { '/var/log/puppet_fstec':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  # Подключение всех требований
  include fstec::section_2_1_1
  include fstec::section_2_1_2
  include fstec::section_2_2_1
  include fstec::section_2_2_2
  include fstec::section_2_3_1
  include fstec::section_2_3_2
  include fstec::section_2_3_3
  include fstec::section_2_3_4
  include fstec::section_2_3_5
  include fstec::section_2_3_6
  include fstec::section_2_3_7
  include fstec::section_2_3_8
  include fstec::section_2_3_9
  include fstec::section_2_3_10
  include fstec::section_2_3_11
  include fstec::section_2_4_1
  include fstec::section_2_4_2
  include fstec::section_2_4_3
  include fstec::section_2_4_4
  include fstec::section_2_4_5
  include fstec::section_2_4_6
  include fstec::section_2_4_7
  include fstec::section_2_4_8
  include fstec::section_2_5_1
  include fstec::section_2_5_2
  include fstec::section_2_5_3
  include fstec::section_2_5_4
  include fstec::section_2_5_5
  include fstec::section_2_5_6
  include fstec::section_2_5_7
  include fstec::section_2_5_8
  include fstec::section_2_5_9
  include fstec::section_2_5_10
  include fstec::section_2_5_11
  include fstec::section_2_6_1
  include fstec::section_2_6_2
  include fstec::section_2_6_3
  include fstec::section_2_6_4
  include fstec::section_2_6_5
  include fstec::section_2_6_6
}
