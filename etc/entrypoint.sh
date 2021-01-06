#!/bin/bash

export CONF_PATH="${CONF_PATH:-/mnt/etc}"
export BASE_PATH="${BASE_PATH:-/var/www/html}"
export ROOT_PATH="${ROOT_PATH:-/var/www/html/web}"

## Replace default apache config
cp $CONF_PATH/apache/default.conf /etc/apache2/sites-available/000-default.conf

SETTINGS=$BASE_PATH/web/sites/default/settings.php
#if [ -f "$SETTINGS" ]; then ; fi
cp $CONF_PATH/drupal/settings.php $SETTINGS && chmod 444 $SETTINGS


# Build dependencies
cp $BASE_PATH && php -d memory_limit=2048M /usr/local/bin/composer install --prefer-dist

# Execute docker cmd replacement
printf "\n\n >> Starting the app \n\n"
rm -rf /run/apache2/* /tmp/apache2*
#exec /etc/init.d/apache2 force-reload
exec /usr/sbin/apachectl -DFOREGROUND
