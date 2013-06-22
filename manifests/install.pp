class n98magerun::install($installation_folder, $magento_version = "magento-ce-1.7.0.2", $db_host = "localhost", $db_user = "root", $db_pass = "", $db_name = "magento", $install_sample_data = false, $use_default_config_params = true, $replace_htaccess_file = false, $base_url = 'http://magento.local') {

    if $replace_htaccess_file == true {
        $formated_replace_htaccess_file = 'yes'
    } else {
        $formated_replace_htaccess_file = 'no'
    }
    if $use_default_config_params == true {
        $formated_use_default_config_params = 'yes'
    } else {
        $formated_use_default_config_params = 'no'
    }
    if $install_sample_data == true {
        $formated_install_sample_data = 'yes'
    } else {
        $formated_install_sample_data = 'no'
    }

    exec { 'install magento':
        command => "/usr/local/bin/n98-magerun.phar install --magentoVersionByName='$magento_version' --installationFolder='$installation_folder' --dbHost='$db_host' --dbUser='$db_user' --dbPass='$db_pass' --dbName='$db_name' --installSampleData='$formated_install_sample_data' --useDefaultConfigParams='$formated_use_default_config_params' --replaceHtaccessFile='$formated_replace_htaccess_files' --baseUrl='$base_url'",
        creates => "$installation_folder/app/etc/local.xml"
    }
}
