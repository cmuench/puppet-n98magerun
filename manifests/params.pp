# Class n98magerun::params
class n98magerun::params {

  $curl_package = 'curl'
  $install_dir  = '/usr/local/bin'
  $stable       = true
  $config_file  = false

  case $::operatingsystem {
    'RedHat', 'Fedora', 'CentOS': {
      $php_package = 'php-cli'
      $php_conf_dir = '/etc/php.d/'
      $php_conf = '/etc/php.ini'

    }
    'Ubuntu', 'Debian': {
      $php_package = 'php5-cli'
      $php_conf_dir = '/etc/php5/conf.d/'
      $php_conf = '/etc/php5/cli/php.ini'
    }
    default: {
      # Bail out, since work will be needed
      fail("Unsupported operatingsystem ${::operatingsystem}.")
    }
  }

}
