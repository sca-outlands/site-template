#!/bin/bash

set -e

www_data_uid=$(grep ^www-data /etc/passwd|cut -d: -f3)
www_data_gid=$(grep ^www-data /etc/group|cut -d: -f3)
read host_uid host_gid <<< $(ls -ndH /var/www/html|awk '{print $3 " " $4}')
switch=0
[ "${host_uid}" -ne "${www_data_uid}" ] && switch=1
[ "${host_gid}" -ne "${www_data_gid}" ] && switch=1
if [ "${switch}" -eq 1 ]; then
    usermod -u "${host_uid}" www-data
    groupmod -g "${host_gid}" www-data
    find / -xdev -user "${www_data_uid}" -exec chown "${host_uid}" {} ';'
    find / -xdev -group "${www_data_uid}" -exec chgrp "${host_gid}" {} ';'
fi

export CONF_PATH="${CONF_PATH:-/mnt/etc}"
export BASE_PATH="${BASE_PATH:-/var/www/html}"
export ROOT_PATH="${ROOT_PATH:-/var/www/html/web}"

# Replace default apache config
cp $CONF_PATH/apache/default.conf /etc/apache2/sites-available/000-default.conf

SETTINGS=$BASE_PATH/web/sites/default/settings.php
#if [ -f "$SETTINGS" ]; then ; fi
cp $CONF_PATH/drupal/settings.php $SETTINGS && chmod 444 $SETTINGS

# Build dependencies
cd $BASE_PATH && php -d memory_limit=2048M /usr/local/bin/composer install --prefer-dist

# Execute docker cmd replacement
printf "\n\n >> Starting the app \n\n"
rm -rf /run/apache2/* /tmp/apache2*
#exec /etc/init.d/apache2 force-reload
exec /usr/sbin/apachectl -DFOREGROUND
