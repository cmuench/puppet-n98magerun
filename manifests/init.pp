class n98magerun {
    exec { 'download n98-magerun':
        command => 'curl -o /usr/local/bin/n98-magerun.phar https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar',
        path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin/' ],
        require => Package["curl"],
        creates => '/usr/local/bin/n98-magerun.phar'
    }

    file { '/usr/local/bin/n98-magerun.phar':
        mode    => '0755',
        owner   => root,
        group   => root,
        require => Exec['download n98-magerun']
      }
}