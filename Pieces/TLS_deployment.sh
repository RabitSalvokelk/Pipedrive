#!/bin/bash

#install openssl and create certs
sudo apt-get install apache2 openssl -y
sudo make-ssl-cert generate-default-snakeoil --force-overwrite
sudo a2enmod ssl
sudo systemctl restart apache2
{
echo 'NameVirtualHost default-ssl:443'
}	 >> /etc/apache2/sites-available/default-ssl.conf
sudo a2ensite default-ssl
sudo systemctl restart apache2

