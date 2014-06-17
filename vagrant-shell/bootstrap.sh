#!/usr/bin/env bash

#BELOW WILL STRT APACHE AFTER VAGRANT HAS MOUNTED
echo "SUBSYSTEM==\"bdi\",ACTION==\"add\",RUN+=\"/usr/bin/screen -m -d bash -c 'sleep 5; service apache2 start'\"" > /etc/udev/rules.d/50-vagrant-mount.rules
echo "SUBSYSTEM==\"bdi\",ACTION==\"remove\",RUN+=\"/usr/bin/screen -m -d bash -c 'sleep 5; service apache2 stop'\"" >> /etc/udev/rules.d/50-vagrant-mount.rules


echo "Start installation of additional packages"
apt-get update
apt-get install curl
apt-get install -y apache2
apt-get install -y php5
apt-get install -y php-apc
apt-get install -y php5-cli
apt-get install -y php5-common
apt-get install -y php5-curl
apt-get install -y php5-gd
apt-get install -y php5-imagick
apt-get install -y php5-intl
apt-get install -y php5-mcrypt
apt-get install -y php5-memcached
apt-get install -y php5-mysqlnd
apt-get install -y php5-sqlite
apt-get install -y php5-xdebug
apt-get install -y php5-xsl
apt-get install -y screen

#ENABLE MOD SSL AND OTHERS
echo "Enable additional apache modules"
a2enmod ssl
a2enmod rewrite
a2enmod include


#CONFIGURE XDEBUG
cp -fr /vagrant/vagrant-shell/apache/xdebug.ini /etc/php5/conf.d/

#ADD COMPOSER
echo "Install Composer"
if [ ! -e "/usr/local/bin/composer.phar" ]
then
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
	chmod 777 /usr/local/bin/composer.phar
fi
composer.phar self-update

#CHANGE PHP SETTING TO DEV FRIENDLY
echo "display_errors = On" >> /etc/php5/apache2/php.ini

#ENABLE PROJECT SITE AND DISABLE DEFAULT
echo "Copy project website file and enable project site"
rm -Rf /etc/apache2/sites-available/project-www.conf
cp -f /vagrant/vagrant-shell/apache/project-www.conf /etc/apache2/sites-available/
a2ensite project-www.conf

#MAKE SURE NETWORK IS UP
ping -c 4 192.168.56.1

sudo service apache2 start

