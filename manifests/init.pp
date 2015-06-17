class n98magerun(
  $curl_package  = $n98magerun::params::curl_package,
  $php_package   = $n98magerun::params::php_package,
  $php_conf_dir  = $n98magerun::params::php_conf_dir,
  $php_conf      = $n98magerun::params::php_conf,
  $install_dir   = $n98magerun::params::install_dir,
  $stable        = $n98magerun::params::stable,
  $config_file   = $n98magerun::params::config_file,

) inherits n98magerun::params {
  include augeas

  # Dependencies
  ensure_packages([$curl_package, $php_package])

  if $stable {
    $download_path = 'https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar'
  } else {
    $download_path = 'https://raw.githubusercontent.com/netz98/n98-magerun/develop/n98-magerun.phar'
  }

  exec { 'download n98-magerun':
    command => "/usr/bin/env curl -L -o n98-magerun.phar ${download_path}",
    creates => "${install_dir}/n98-magerun.phar",
    cwd     => $install_dir,
    require => [
      Package[$curl_package, $php_package],
      Augeas['whitelist_phar', 'allow_url_fopen']
    ]
  }

  file { 'n98-magerun.phar':
    path    => "${install_dir}/n98-magerun.phar",
    mode    => '0755',
    owner   => root,
    group   => root,
    require => Exec['download n98-magerun']
  }

  if $config_file {
    file { '.n98-magerun.yaml':
      ensure => present,
      path   => "${install_dir}/.n98-magerun.yaml",
      source => $config_file,
      owner  => root,
      group  => root
    }
  }

  augeas { 'whitelist_phar':
    context => "/files${php_conf_dir}/suhosin.ini/suhosin",
    changes => 'set suhosin.executor.include.whitelist phar',
    require => Package[$php_package]
  }

  augeas{ 'allow_url_fopen':
    context => "/files${php_conf}/PHP",
    changes => 'set allow_url_fopen On',
    require => Package[$php_package]
  }
}
