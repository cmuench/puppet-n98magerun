class n98magerun::install(
    $installation_folder       = $n98magerun::install::params::installation_folder,
    $magento_version           = $n98magerun::install::params::magento_version,
    $db_host                   = $n98magerun::install::params::db_host,
    $db_user                   = $n98magerun::install::params::db_user,
    $db_pass                   = $n98magerun::install::params::db_pass,
    $db_name                   = $n98magerun::install::params::db_name,
    $install_sample_data       = $n98magerun::install::params::install_sample_data,
    $use_default_config_params = $n98magerun::install::params::use_default_config_params,
    $replace_htaccess_file     = $n98magerun::install::params::replace_htaccess_file,
    $base_url                  = $n98magerun::install::params::base_url,
    $installation_timeout      = $n98magerun::install::params::installation_timeout
) inherits n98magerun::install::params {
    require n98magerun

    if $replace_htaccess_file == true {
        $real_replace_htaccess_file = 'yes'
    } else {
        $real_replace_htaccess_file = 'no'
    }
    if $use_default_config_params == true {
        $real_use_default_config_params = 'yes'
    } else {
        $real_use_default_config_params = 'no'
    }
    if $install_sample_data == true {
        $real_install_sample_data = 'yes'
    } else {
        $real_install_sample_data = 'no'
    }

    exec { 'install magento':
        command     => "/usr/bin/env php -dmemory_limit=1G /usr/local/bin/n98-magerun.phar install --magentoVersionByName='${magento_version}' --installationFolder='${installation_folder}' --dbHost='${db_host}' --dbUser='${db_user}' --dbPass='${db_pass}' --dbName='${db_name}' --installSampleData='${real_install_sample_data}' --useDefaultConfigParams='${real_use_default_config_params}' --replaceHtaccessFile='${real_replace_htaccess_files}' --baseUrl='${base_url}'",
        creates     => "${installation_folder}/app/etc/local.xml",
        timeout     => $installation_timeout,
        logoutput   => 'on_failure',
        environment => 'HOME=/root',
    }
}
