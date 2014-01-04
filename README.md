# puppet module to use n98-magerun

Currently work in progress...

Example magento installation with n98-magerun and puppet:

    class { "n98magerun": } # downloads n98-magerun and puts it to /usr/local/bin

    class { "n98magerun::install":
        installation_folder => "/vagrant_data",
        db_host             => "localhost",
        db_user             => "root",
        db_pass             => "root",
        db_name             => "magento",
        base_url            => "http://127.0.0.1:8080",
        install_sample_data => true
    }

Download develop version of n98-magerun:

    class { "n98magerun": 
      stable => false
    }

