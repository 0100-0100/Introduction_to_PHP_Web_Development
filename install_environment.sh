#!/usr/bin/env bash
sudo apt install nginx php8.3-fpm -y

# Move php nginx config to sites available dir.
sudo mv ./nginx_php_dev_config /etc/nginx/sites-available/php
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/php /etc/nginx/sites-enabled/php
sudo nginx -t
if [ $? -eq 1 ]; then
    echo -e "\033[91mNGINX Config file is not correct.\033[m";
    exit;
fi

# Validate NGINX config and status of NGINX and PHP-FPM
sudo service nginx start;
if [ $? -eq 0 ]; then
    echo -e "\033[92mNGINX Running correctly\033[m";
    sudo service nginx restart;
else
    echo -e "\033[91mNGINX Not Running correctly\033[m";
    exit
fi

sudo systemctl status php8.3-fpm;
if [ $? -eq 0 ]; then
    echo -e "\033[92mPHP 8.3 FPM Running correctly\033[m";
    sudo service php8.3-fpm restart;
else
    echo -e "\033[91mPHP 8.3 FPM Not Running correctly\033[m"
    exit
fi

# Create Basic Test PHP File.
sudo mv ./info.php /var/www/html/info.php
