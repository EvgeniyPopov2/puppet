Рекомендации по безопасной настройке операционных систем Linux
Настоящие Рекомендации по безопасной настройке операционных систем Linux разработаны в соответствии с подпунктом 4 пункта 8 Положения о Федеральной службе по техническому и экспортному контролю, утверждённого Указом Президента Российской Федерации от 16 августа 2004 г. № 1085.

Данный проект предоставляет набор модулей Puppet для автоматизации применения этих рекомендаций на серверах под управлением операционных систем семейства Linux.

Содержание
Требования
Установка
Использование
Описание модулей
Требование 2.1.1
Требование 2.1.2
Требование 2.2.1
Требование 2.2.2
Требование 2.3.1
Требование 2.3.2
Требование 2.3.3
Требование 2.3.4
Требование 2.3.5
Требование 2.3.6
Требование 2.3.7
Требование 2.3.8
Требование 2.3.9
Требование 2.3.10
Требование 2.3.11
Требование 2.4.1
Требование 2.4.2
Требование 2.4.3
Требование 2.4.4
Требование 2.4.5
Требование 2.4.6
Требование 2.4.7
Требование 2.4.8
Требование 2.5.1
Требование 2.5.2
Требование 2.5.3
Требование 2.5.4
Требование 2.5.5
Требование 2.5.6
Требование 2.5.7
Требование 2.5.8
Требование 2.5.9
Требование 2.5.10
Требование 2.5.11
Требование 2.6.1
Требование 2.6.2
Требование 2.6.3
Требование 2.6.4
Требование 2.6.5
Требование 2.6.6
Лицензия
Контакты
Требования
Puppet 5.5 или выше
Операционная система семейства Linux (поддерживаются дистрибутивы на основе Debian и RedHat)
Права суперпользователя на управляемых узлах
Установка
Клонируйте репозиторий в каталог Puppet-модулей:

bash
Копировать код
git clone https://github.com/yourusername/fstec.git /etc/puppetlabs/code/environments/production/modules/fstec
Убедитесь, что все зависимости указаны и установлены.

Использование
В файле site.pp подключите модуль fstec для узлов, на которых необходимо применить рекомендации:

puppet
Копировать код
node default {
  include fstec
}
При необходимости настройте параметры в Hiera для следующих ключей:

common.yaml
Копировать код
wheel::users:
  - root
  - user1
  - admin

sudo::users:
  - user1
  - admin

sudo::files:
  - '/usr/local/bin/some_script'
  - '/usr/local/bin/another_script'

suid_sgid::whitelist:
  - '/usr/bin/passwd'
  - '/usr/bin/sudo'
  - '/bin/ping'
Запустите применение конфигурации Puppet:

bash
Копировать код
puppet agent -t
Описание модулей
Требование 2.1.1
Описание: Не допускать использование учетных записей пользователей с пустыми паролями. Настроить учетные записи таким образом, чтобы каждый пользователь системы либо имел пароль, либо был заблокирован по паролю.

Модуль: fstec::section_2_1_1

Действия:

Блокирует учетные записи с пустыми паролями.
Логирует применение требования.
Требование 2.1.2
Описание: Отключить вход суперпользователя в систему по протоколу SSH путём установки для параметра PermitRootLogin значения no в файле /etc/ssh/sshd_config.

Модуль: fstec::section_2_1_2

Действия:

Настраивает SSH для запрета входа под пользователем root.
Перезапускает сервис SSH для применения изменений.
Логирует применение требования.
Требование 2.2.1
Описание: Ограничить доступ к команде su путём добавления в файл /etc/pam.d/su строки auth required pam_wheel.so use_uid. Задать список пользователей в группе wheel.

Модуль: fstec::section_2_2_1

Действия:

Настраивает PAM для ограничения доступа к su.
Создает группу wheel и добавляет в нее указанных пользователей.
Логирует применение требования.
Требование 2.2.2
Описание: Ограничить список пользователей, которым разрешено использовать команду sudo, и разрешенных к выполнению через sudo команд путём пересмотра файла /etc/sudoers.

Модуль: fstec::section_2_2_2

Действия:

Устанавливает пакет sudo, если не установлен.
Создает файл /etc/sudoers.d/limited_users с ограничениями.
Логирует применение требования.
Требование 2.3.1
Описание: Установить корректные права доступа к файлам настроек пользователей: /etc/passwd, /etc/group, /etc/shadow.

Модуль: fstec::section_2_3_1

Действия:

Устанавливает права 0644 для /etc/passwd и /etc/group.
Устанавливает права 0400 для /etc/shadow.
Логирует применение требования.
Требование 2.3.2
Описание: Установить корректные права доступа к файлам запущенных процессов.

Модуль: fstec::section_2_3_2

Действия:

Изменяет права доступа к исполняемым файлам запущенных процессов.
Логирует применение требования.
Требование 2.3.3
Описание: Установить корректные права доступа к файлам, выполняющимся с помощью планировщика задач cron неавторизованными пользователями.

Модуль: fstec::section_2_3_3

Действия:

Изменяет права доступа к файлам, вызываемым из заданий cron.
Логирует применение требования.
Требование 2.3.4
Описание: Установить корректные права доступа к файлам, выполняемым с помощью sudo.

Модуль: fstec::section_2_3_4

Действия:

Изменяет владельца и права доступа к указанным файлам.
Логирует применение требования.
Требование 2.3.5
Описание: Установить корректные права доступа к стартовым скриптам системы.

Модуль: fstec::section_2_3_5

Действия:

Изменяет права доступа к файлам в /etc/rc#.d и .service файлам.
Логирует применение требования.
Требование 2.3.6
Описание: Установить корректные права доступа к системным файлам заданий cron.

Модуль: fstec::section_2_3_6

Действия:

Изменяет права доступа к системным файлам и директориям cron.
Логирует применение требования.
Требование 2.3.7
Описание: Установить корректные права доступа к пользовательским файлам заданий cron.

Модуль: fstec::section_2_3_7

Действия:

Изменяет права доступа к пользовательским файлам cron.
Логирует применение требования.
Требование 2.3.8
Описание: Установить корректные права доступа к исполняемым файлам и библиотекам операционной системы.

Модуль: fstec::section_2_3_8

Действия:

Изменяет права доступа в стандартных каталогах исполняемых файлов и библиотек.
Логирует применение требования.
Требование 2.3.9
Описание: Установить корректные права доступа к SUID/SGID-приложениям.

Модуль: fstec::section_2_3_9

Действия:

Изменяет права доступа к SUID/SGID-приложениям.
Удаляет лишние SUID/SGID-биты, не входящие в "белый список".
Логирует применение требования.
Требование 2.3.10
Описание: Установить корректные права доступа к содержимому домашних директорий пользователей.

Модуль: fstec::section_2_3_10

Действия:

Изменяет права доступа к файлам настроек оболочки и истории команд в домашних директориях пользователей.
Логирует применение требования.
Требование 2.3.11
Описание: Установить корректные права доступа к домашним директориям пользователей.

Модуль: fstec::section_2_3_11

Действия:

Изменяет права доступа к домашним директориям указанных пользователей.
Логирует применение требования.
Требование 2.4.1
Описание: Ограничить доступ к журналу ядра путём установки kernel.dmesg_restrict=1.

Модуль: fstec::section_2_4_1

Действия:

Устанавливает значение kernel.dmesg_restrict через sysctl.
Логирует применение требования.
Требование 2.4.2
Описание: Заменить ядерные адреса в /proc и других интерфейсах на 0 путём установки kernel.kptr_restrict=2.

Модуль: fstec::section_2_4_2

Действия:

Устанавливает значение kernel.kptr_restrict через sysctl.
Логирует применение требования.
Требование 2.4.3
Описание: Инициализировать динамическую ядерную память нулем при ее выделении путём установки опции загрузки ядра init_on_alloc=1.

Модуль: fstec::section_2_4_3

Действия:

Добавляет параметр загрузки ядра.
Обновляет конфигурацию GRUB.
Логирует применение требования.
Требование 2.4.4
Описание: Запретить слияние кэшей ядерного аллокатора путём установки опции загрузки ядра slab_nomerge.

Модуль: fstec::section_2_4_4

Действия:

Добавляет параметр загрузки ядра.
Обновляет конфигурацию GRUB.
Логирует применение требования.
Требование 2.4.5
Описание: Инициализировать механизм IOMMU путём установки следующих опций загрузки ядра:

iommu=force
iommu.strict=1
iommu.passthrough=0
Модуль: fstec::section_2_4_5

Действия:

Добавляет параметры загрузки ядра.
Обновляет конфигурацию GRUB.
Логирует применение требования.
Требование 2.4.6
Описание: Рандомизировать расположение ядерного стека путём установки опции загрузки ядра randomize_kstack_offset=1.

Модуль: fstec::section_2_4_6

Действия:

Добавляет параметр загрузки ядра.
Обновляет конфигурацию GRUB.
Логирует применение требования.
Требование 2.4.7
Описание: Включить средства защиты от аппаратных уязвимостей центрального процессора (для платформы x86) путём установки опции загрузки ядра mitigations=auto,nosmt.

Модуль: fstec::section_2_4_7

Действия:

Добавляет параметр загрузки ядра.
Обновляет конфигурацию GRUB.
Логирует применение требования.
Требование 2.4.8
Описание: Включить защиту подсистемы eBPF JIT ядра Linux путём установки net.core.bpf_jit_harden=2.

Модуль: fstec::section_2_4_8

Действия:

Устанавливает значение net.core.bpf_jit_harden через sysctl.
Логирует применение требования.
Требование 2.5.1
Описание: Отключить устаревший интерфейс vsyscall путём установки опции загрузки ядра vsyscall=none.

Модуль: fstec::section_2_5_1

Действия:

Добавляет параметр загрузки ядра.
Обновляет конфигурацию GRUB.
Логирует применение требования.
Требование 2.5.2
Описание: Ограничить доступ к событиям производительности путём установки kernel.perf_event_paranoid=3.

Модуль: fstec::section_2_5_2

Действия:

Устанавливает значение kernel.perf_event_paranoid через sysctl.
Логирует применение требования.
Требование 2.5.3
Описание: Отключить автоматическое монтирование debugfs путём установки опции загрузки ядра debugfs=no-mount.

Модуль: fstec::section_2_5_3

Действия:

Добавляет параметр загрузки ядра.
Обновляет конфигурацию GRUB.
Логирует применение требования.
Требование 2.5.4
Описание: Отключить системный вызов kexec_load путём установки kernel.kexec_load_disabled=1.

Модуль: fstec::section_2_5_4

Действия:

Устанавливает значение kernel.kexec_load_disabled через sysctl.
Логирует применение требования.
Требование 2.5.5
Описание: Ограничить использование user namespaces путём установки user.max_user_namespaces=0.

Модуль: fstec::section_2_5_5

Действия:

Устанавливает значение user.max_user_namespaces через sysctl.
Логирует применение требования.
Требование 2.5.6
Описание: Запретить системный вызов bpf для непривилегированных пользователей путём установки kernel.unprivileged_bpf_disabled=1.

Модуль: fstec::section_2_5_6

Действия:

Устанавливает значение kernel.unprivileged_bpf_disabled через sysctl.
Логирует применение требования.
Требование 2.5.7
Описание: Запретить системный вызов userfaultfd для непривилегированных пользователей путём установки vm.unprivileged_userfaultfd=0.

Модуль: fstec::section_2_5_7

Действия:

Устанавливает значение vm.unprivileged_userfaultfd через sysctl.
Логирует применение требования.
Требование 2.5.8
Описание: Запретить автоматическую загрузку модулей ядра для поддержки дисциплины линии терминала путём установки dev.tty.ldisc_autoload=0.

Модуль: fstec::section_2_5_8

Действия:

Устанавливает значение dev.tty.ldisc_autoload через sysctl.
Логирует применение требования.
Требование 2.5.9
Описание: Отключить технологию Transactional Synchronization Extensions (TSX) путём установки опции загрузки ядра tsx=off.

Модуль: fstec::section_2_5_9

Действия:

Добавляет параметр загрузки ядра.
Обновляет конфигурацию GRUB.
Логирует применение требования.
Требование 2.5.10
Описание: Настроить минимальный виртуальный адрес для mmap путём установки vm.mmap_min_addr=4096 или больше.

Модуль: fstec::section_2_5_10

Действия:

Устанавливает значение vm.mmap_min_addr через sysctl.
Логирует применение требования.
Требование 2.5.11
Описание: Реализовать рандомизацию адресного пространства путём установки kernel.randomize_va_space=2.

Модуль: fstec::section_2_5_11

Действия:

Устанавливает значение kernel.randomize_va_space через sysctl.
Логирует применение требования.
Требование 2.6.1
Описание: Запретить подключение к другим процессам с помощью ptrace путём установки kernel.yama.ptrace_scope=3.

Модуль: fstec::section_2_6_1

Действия:

Устанавливает значение kernel.yama.ptrace_scope через sysctl.
Логирует применение требования.
Требование 2.6.2
Описание: Ограничить небезопасные варианты работы с символическими ссылками путём установки fs.protected_symlinks=1.

Модуль: fstec::section_2_6_2

Действия:

Устанавливает значение fs.protected_symlinks через sysctl.
Логирует применение требования.
Требование 2.6.3
Описание: Ограничить небезопасные варианты работы с жесткими ссылками путём установки fs.protected_hardlinks=1.

Модуль: fstec::section_2_6_3

Действия:

Устанавливает значение fs.protected_hardlinks через sysctl.
Логирует применение требования.
Требование 2.6.4
Описание: Включить защиту от непреднамеренной записи в FIFO-объекты путём установки fs.protected_fifos=2.

Модуль: fstec::section_2_6_4

Действия:

Устанавливает значение fs.protected_fifos через sysctl.
Логирует применение требования.
Требование 2.6.5
Описание: Включить защиту от непреднамеренной записи в файлы путём установки fs.protected_regular=2.

Модуль: fstec::section_2_6_5

Действия:

Устанавливает значение fs.protected_regular через sysctl.
Логирует применение требования.
Требование 2.6.6
Описание: Запретить создание core dump для некоторых исполняемых файлов путём установки fs.suid_dumpable=0.

Модуль: fstec::section_2_6_6

Действия:

Устанавливает значение fs.suid_dumpable через sysctl.
Логирует применение требования.
Лицензия
Данный проект распространяется под Лицензия GPL-3.0. Подробнее см. в файле LICENSE.

Контакты
Если у вас есть вопросы или предложения, пожалуйста, свяжитесь с нами:

Автор: Попов Евгений

