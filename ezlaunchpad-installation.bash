#!/bin/bash
# ezlaunchpad installation + dependencies

# Install PHP
sudo apt-get install -y php php-cli php-curl php-mbstring php-xml php-dom php-simplexml

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Download + Install ezlaunchpad
curl -LSs https://ezsystems.github.io/launchpad/install_curl.bash | bash
mv ez /usr/local/bin
