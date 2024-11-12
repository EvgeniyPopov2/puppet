# /etc/puppetlabs/code/environments/production/manifests/site.pp

# Подключение модуля fstec ко всем узлам
node default {
  include fstec
}
