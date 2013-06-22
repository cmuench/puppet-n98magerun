class n98magerun {

  exec { 'download n98-magerun':
    command => 'wget https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar -O /usr/local/bin/n98-magerun.phar',
    creates => '/usr/local/bin/n98-magerun.phar',
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ];
  }

  file { '/usr/local/bin/n98-magerun.phar':
    mode    => '0755',
    owner   => root,
    group   => root,
    require => Exec['download n98-magerun']
  }
}
