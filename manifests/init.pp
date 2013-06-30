class n98magerun(
  $php_package = 'php5-cli'
) {
  include augeas

  exec { 'download n98-magerun':
    command => 'curl -o /usr/local/bin/n98-magerun.phar https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar',
    creates => '/usr/local/bin/n98-magerun.phar',
    require     => [
      Package['curl', $php_package],
      Augeas['whitelist_phar', 'allow_url_fopen']
    ]
  }

  file { '/usr/local/bin/n98-magerun.phar':
    mode    => '0755',
    owner   => root,
    group   => root,
    require => Exec['download n98-magerun']
  }

  augeas { 'whitelist_phar':
    context => '/files/etc/php5/conf.d/suhosin.ini/suhosin',
    changes => 'set suhosin.executor.include.whitelist phar',
    require => Package[$php_package]
  }

  augeas{ 'allow_url_fopen':
    context => '/files/etc/php5/cli/php.ini/PHP',
    changes => 'set allow_url_fopen On',
    require => Package[$php_package]
  }
}